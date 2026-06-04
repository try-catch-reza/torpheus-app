import 'package:equatable/equatable.dart';

class PerfisModel extends Equatable {
  const PerfisModel({
    this.nome,
    this.permissoes,
    this.id,
    this.isSystem,
    this.isActive,
  });

  final String? id;
  final String? nome;
  final bool? isSystem;
  final bool? isActive;
  final List<String>? permissoes;

  factory PerfisModel.fromJson(Map<String, dynamic> json) {
    return PerfisModel(
      id: json['id'] as String?,
      nome: json['name'] as String?,
      isSystem: json['isSystem'] as bool?,
      isActive: json['isActive'] as bool?,
      permissoes: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'isSystem': isSystem,
      'isActive': isActive,
      'permissoes': permissoes,
    };
  }

  Map<String, dynamic> toJsonAPI() {
    return {
      'name': nome,
      'permissions': permissoes,
    };
  }

  Map<String, dynamic> toJsonPUT() {
    return {
      'roleId': id,
      'name': nome,
      'permissions': permissoes,
    };
  }

  @override
  String toString() {
    return 'PerfilModel{'
        'id: $id, '
        'nome: $nome, '
        'isSystem: $isSystem, '
        'isActive: $isActive, '
        'permissoes: $permissoes,'
        '}';
  }

  @override
  List<Object?> get props => [
        id,
        nome,
        isSystem,
        isActive,
        permissoes,
      ];
}
