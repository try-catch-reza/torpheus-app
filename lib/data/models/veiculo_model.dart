import 'package:equatable/equatable.dart';

class VeiculoModel extends Equatable {
  const VeiculoModel({
    this.placa,
    this.modelo,
    this.ano,
    this.cor,
  });

  final String? placa;
  final String? modelo;
  final String? ano;
  final String? cor;

  @override
  List<Object?> get props => throw UnimplementedError();
}
