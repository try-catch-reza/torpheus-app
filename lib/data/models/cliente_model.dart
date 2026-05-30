import 'package:equatable/equatable.dart';
import 'package:torpheus/core/constants/enum/documento_tipo.dart';
import 'package:torpheus/data/models/endereco_model.dart';

class ClienteModel extends Equatable {
  const ClienteModel({
    this.id,
    this.nome,
    this.telefone,
    this.documento,
    this.documentoTipo,
    this.email,
    this.isActive,
    this.createdAt,
    this.endereco = const EnderecoModel(),
  });

  final String? id;
  final String? nome;
  final String? telefone;
  final String? documento;
  final DocumentoTipo? documentoTipo;
  final String? email;
  final bool? isActive;
  final DateTime? createdAt;
  final EnderecoModel endereco;

  ClienteModel copyWith({
    String? id,
    String? nome,
    String? telefone,
    String? documento,
    DocumentoTipo? documentoTipo,
    String? email,
    bool? isActive,
    DateTime? createdAt,
    EnderecoModel? endereco,
  }) {
    return ClienteModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      documento: documento ?? this.documento,
      documentoTipo: documentoTipo ?? this.documentoTipo,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      endereco: endereco ?? this.endereco,
    );
  }

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      id: json['id'] as String?,
      nome: json['name'] as String?,
      telefone: json['phone'] as String?,
      documento: json['document'] as String?,
      documentoTipo: json['documentType'] != null
          ? DocumentoTipo.values.firstWhere(
              (e) => e.value == json['documentType'],
              orElse: () => throw ArgumentError(
                'Valor inválido para DocumentoTipo: ${json['documentType']}',
              ),
            )
          : null,
      email: json['email'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      endereco: json['address'] != null
          ? EnderecoModel.fromJson(json['address'] as Map<String, dynamic>)
          : const EnderecoModel(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': nome,
      'phone': telefone,
      'documentNumber': documento,
      'documentType': documentoTipo?.value,
      'email': email,
      'address': endereco.toJson(),
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      'name': nome,
      'phone': telefone,
      'documentNumber': documento,
      'documentType': documentoTipo?.value,
      'email': email,
      'isActive': isActive,
      'address': endereco.toJson(),
    };
  }

  @override
  toString() {
    return 'ClienteModel('
        'id: $id, '
        'nome: $nome, '
        'telefone: $telefone, '
        'documento: $documento, '
        'documentoTipo: ${documentoTipo?.value}, '
        'email: $email, '
        'isActive: $isActive, '
        'createdAt: $createdAt,'
        'endereco: $endereco, '
        ')';
  }

  @override
  List<Object?> get props => [
        id,
        nome,
        telefone,
        documento,
        documentoTipo,
        email,
        isActive,
        createdAt,
        endereco,
      ];
}
