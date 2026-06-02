import 'package:equatable/equatable.dart';

class VeiculoModel extends Equatable {
  const VeiculoModel({
    this.tipo,
    this.placa,
    this.marca,
    this.modelo,
    this.motor,
    this.ano,
    this.cambio,
    this.combustivel,
  });

  final String? tipo;
  final String? placa;
  final String? marca;
  final String? modelo;
  final String? motor;
  final String? ano;
  final String? cambio;
  final String? combustivel;


  @override
  List<Object?> get props => throw UnimplementedError();
}
