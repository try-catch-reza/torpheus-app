import 'package:equatable/equatable.dart';
import 'package:torpheus/core/constants/enum/cambio_veiculo.dart';
import 'package:torpheus/core/constants/enum/tipo_veiculo.dart';
import 'package:torpheus/core/constants/enum/combustivel_veiculo.dart';

import '../../core/constants/enum/marca_veiculo.dart';

class VeiculoModel extends Equatable {
  const VeiculoModel({
    this.id,
    this.tipo,
    this.placa,
    this.marca,
    this.modelo,
    this.motor,
    this.ano,
    this.cambio,
    this.combustivel,
    this.isActive,
    this.createdAt,
  });

  final String? id;
  final TipoVeiculo? tipo;
  final String? placa;
  final MarcaVeiculo? marca;
  final String? modelo;
  final String? motor;
  final int? ano;
  final CambioVeiculo? cambio;
  final CombustivelVeiculo? combustivel;
  final bool? isActive;
  final DateTime? createdAt;

  String get subTitle {
    return '$modelo $ano';
  }

  factory VeiculoModel.fromJson(Map<String, dynamic> json) {
    return VeiculoModel(
      id: json['id'],
      tipo: TipoVeiculo.fromValue(json['type']),
      placa: json['licensePlate'],
      marca: MarcaVeiculo.fromValue(json['brand']),
      modelo: json['model'],
      motor: json['engine'],
      cambio: CambioVeiculo.fromValue(json['transmission']),
      ano: json['manufactureYear'],
      combustivel: CombustivelVeiculo.fromValue(json['fuel']),
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': tipo?.value,
      'licensePlate': placa,
      'brand': marca?.value,
      'model': modelo,
      'engine': motor,
      'transmission': cambio?.value,
      'manufactureYear': ano,
      'fuel': combustivel?.value,
    };
  }

  @override
  String toString() {
    return 'VeiculoModel{'
        'tipo: $tipo, '
        'placa: $placa, '
        'marca: $marca, '
        'modelo: $modelo, '
        'motor: $motor, '
        'ano: $ano, '
        'cambio: $cambio, '
        'combustivel: $combustivel,'
        '}';
  }

  @override
  List<Object?> get props => [
        id,
        tipo,
        placa,
        marca,
        modelo,
        motor,
        ano,
        cambio,
        combustivel,
        isActive,
        createdAt,
      ];
}
