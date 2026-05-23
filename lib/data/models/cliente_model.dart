import 'package:equatable/equatable.dart';

class ClienteModel extends Equatable {
  const ClienteModel({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.telefone,
    required this.email,
    required this.totalVeiculos,
  });

  final String id;
  final String nome;
  final String cpf;
  final String telefone;
  final String email;
  final int totalVeiculos;

  String get iniciais {
    final partes = nome.trim().split(' ');
    if (partes.length >= 2) {
      return '${partes.first[0]}${partes.last[0]}'.toUpperCase();
    }
    return partes.first.substring(0, 2).toUpperCase();
  }

  @override
  toString() {
    return 'ClienteModel('
        'id: $id, '
        'nome: $nome, '
        'cpf: $cpf, '
        'telefone: $telefone, '
        'email: $email, '
        'totalVeiculos: $totalVeiculos,'
        ')';
  }

  @override
  List<Object?> get props => [id, nome, cpf, telefone, email, totalVeiculos];
}
