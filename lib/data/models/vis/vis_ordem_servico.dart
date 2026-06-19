import 'package:equatable/equatable.dart';
import 'package:torpheus/core/constants/enum/status_ordem.dart';

class VisOrdemServico extends Equatable {
  final String numeroOs;
  final String placa;
  final String modelo;
  final String cliente;
  final int quantServico;
  final DateTime dataEntrada;
  final String mecanico;
  final StatusOrdem status;

  const VisOrdemServico({
    required this.numeroOs,
    required this.placa,
    required this.modelo,
    required this.cliente,
    required this.quantServico,
    required this.dataEntrada,
    required this.mecanico,
    required this.status,
  });

  @override
  List<Object?> get props => [
        numeroOs,
        placa,
        modelo,
        cliente,
        quantServico,
        dataEntrada,
        mecanico,
        status,
      ];

  @override
  String toString() {
    return 'VisOrdemServico{'
        'numeroOs: $numeroOs,'
        ' placa: $placa,'
        ' modelo: $modelo,'
        ' cliente: $cliente,'
        ' quantServico: $quantServico,'
        ' dataEntrada: $dataEntrada,'
        ' mecanico: $mecanico,'
        ' status: ${status.value},'
        '}';
  }
}
