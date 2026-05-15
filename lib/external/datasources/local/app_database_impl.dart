import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/constants/db_constants.dart';
import '../../../data/datasources/local/app_database.dart';

class ApplicationDatabaseImpl implements ApplicationDatabase {
  static ApplicationDatabaseImpl? _instance;

  static Future<ApplicationDatabaseImpl> initialize() async =>
      _instance ??= ApplicationDatabaseImpl._(await _initialize());

  ApplicationDatabaseImpl._(Database database) : db = database;

  @override
  Database db;

  @override
  Future<String> getDbPath() async => await getDatabasesPath();

  static Future<Database> _initialize() async {
    if (kIsWeb) {
      throw UnsupportedError('SQLite não suportado no Flutter Web');
    }

    late String databasesPath;

    if (Platform.isWindows) {
      databasesPath = await getDatabasesPath();
    }

    if (Platform.isAndroid || Platform.isIOS) {
      databasesPath = await getDatabasesPath();
    }

    final path = join(
      databasesPath,
      DatabaseConstants.dbName,
    );

    return await openDatabase(
      path,
      version: DatabaseConstants.version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  static void _onCreate(Database db, int newVersion) async {
    final String s = await rootBundle.loadString(DatabaseConstants.create);

    final List<String> sqls = s.split(';');

    for (String sql in sqls) {
      if (sql.trim().isNotEmpty) {
        await db.execute(sql);
      }
    }
  }

  //Para o SQlite aceitar chaves estrangeiras
  static FutureOr<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static Future<FutureOr<void>> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    /// Verifica a versão atual e nova versão do banco de dados
    if (oldVersion < DatabaseConstants.version) {
      /// Pega a partir da versão atual
      for (int i = oldVersion + 1; i <= DatabaseConstants.version; i++) {
        try {
          /// Abre o arquivo
          final String s = await rootBundle
              .loadString('${DatabaseConstants.pathUpgrade}$i.sql');

          final List<String> sqls = s.split(";");

          for (String sql in sqls) {
            if (sql.trim().isNotEmpty) {
              try {
                /// Executa a instrução  SQL
                await db.execute(sql);
              } catch (e) {
                if (kDebugMode) {
                  print(e);
                }
                continue;
              }
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          continue;
        }
      }
    }
  }
}
