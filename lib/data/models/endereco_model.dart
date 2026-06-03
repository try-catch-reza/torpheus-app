import 'package:equatable/equatable.dart';

class EnderecoModel extends Equatable {
  const EnderecoModel({
    this.rua,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
    this.cep,
  });

  final String? rua;
  final String? numero;
  final String? complemento;
  final String? bairro;
  final String? cidade;
  final String? estado;
  final String? cep;

  String get labelRuaNumero {
    if (rua != null && numero != null) {
      return '$rua, $numero';
    } else if (rua != null) {
      return rua!;
    } else if (numero != null) {
      return numero!;
    } else {
      return '';
    }
  }

  factory EnderecoModel.fromJson(Map<String, dynamic> json) {
    return EnderecoModel(
      rua: json['street'] as String?,
      numero: json['number'] as String?,
      complemento: json['complement'] as String?,
      bairro: json['neighborhood'] as String?,
      cidade: json['city'] as String?,
      estado: json['state'] as String?,
      cep: json['zipCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': rua,
      'number': numero,
      'complement': complemento,
      'neighborhood': bairro,
      'city': cidade,
      'state': estado,
      'zipCode': cep,
    };
  }

  @override
  String toString() {
    return 'EnderecoModel('
        'rua: $rua, '
        'numero: $numero, '
        'complemento: $complemento, '
        'bairro: $bairro, '
        'cidade: $cidade, '
        'estado: $estado,'
        ' cep: $cep, '
        ')';
  }

  @override
  List<Object?> get props => [
        rua,
        numero,
        complemento,
        bairro,
        cidade,
        estado,
        cep,
      ];
}
