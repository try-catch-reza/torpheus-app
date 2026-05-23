import 'package:torpheus/data/models/veiculo_cliente_model.dart';

import 'cliente_estatisticas.dart';

class ClienteDetalheModel {
  const ClienteDetalheModel({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.telefone,
    required this.email,
    required this.status,
    required this.veiculos,
    required this.estatisticas,
  });

  final String id;
  final String nome;
  final String cpf;
  final String telefone;
  final String email;
  final String status;
  final List<VeiculoClienteModel> veiculos;
  final ClienteEstatisticas estatisticas;

  String get iniciais {
    final partes = nome.trim().split(' ');
    if (partes.length >= 2) {
      return '${partes.first[0]}${partes.last[0]}'.toUpperCase();
    }
    return partes.first.substring(0, 2).toUpperCase();
  }
}
