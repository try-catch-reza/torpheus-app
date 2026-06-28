import 'package:equatable/equatable.dart';

import '../../core/constants/enum/granularidade.dart';
import 'baldes_model.dart';

class IndicadorOrdemServicoPeriodoModel extends Equatable {
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final Granularidade? granularidade;
  final List<BaldesModel>? baldes;

  const IndicadorOrdemServicoPeriodoModel({
    this.dataInicio,
    this.dataFim,
    this.granularidade,
    this.baldes,
  });

  factory IndicadorOrdemServicoPeriodoModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return IndicadorOrdemServicoPeriodoModel(
      dataInicio:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      dataFim: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      granularidade: Granularidade.fromValue(json['granularity']),
      baldes: json['buckets'] != null
          ? List<BaldesModel>.from(
              json['buckets'].map((x) => BaldesModel.fromJson(x)),
            )
          : null,
    );
  }

  @override
  String toString() {
    return 'IndicadorOrdemServicoPeriodoModel(dataInicio: $dataInicio, dataFim: $dataFim, granularidade: $granularidade, baldes: $baldes)';
  }

  @override
  List<Object?> get props => [dataInicio, dataFim, granularidade, baldes];
}
