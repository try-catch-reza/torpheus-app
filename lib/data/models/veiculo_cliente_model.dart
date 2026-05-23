import 'package:equatable/equatable.dart';

import '../../core/constants/enum/status_veiculo.dart';

class VeiculoClienteModel extends Equatable {
  const VeiculoClienteModel({
    required this.id,
    required this.placa,
    required this.modelo,
    required this.ano,
    required this.cor,
    required this.combustivel,
    required this.totalOs,
    required this.status,
  });

  final String id;
  final String placa;
  final String modelo;
  final String ano;
  final String cor;
  final String combustivel;
  final int totalOs;
  final StatusVeiculo status;

  String get descricao => '$cor · $combustivel · $totalOs OS deste cliente';

  @override
  String toString() {
    return 'VeiculoClienteModel('
        'id: $id,'
        ' placa: $placa, '
        'modelo: $modelo, '
        'ano: $ano, '
        'cor: $cor, '
        'combustivel: $combustivel, '
        'totalOs: $totalOs, '
        'status: $status,'
        ')';
  }

  @override
  List<Object?> get props => [
        id,
        placa,
        modelo,
        ano,
        cor,
        combustivel,
        totalOs,
        status,
      ];
}
