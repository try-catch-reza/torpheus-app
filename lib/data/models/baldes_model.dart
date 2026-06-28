import 'package:equatable/equatable.dart';

class BaldesModel extends Equatable {
  final DateTime? data;
  final int? total;
  final int? totalAbertos;
  final int? emProgresso;
  final int? completos;
  final int? cancelados;

  const BaldesModel({
    this.data,
    this.total,
    this.totalAbertos,
    this.emProgresso,
    this.completos,
    this.cancelados,
  });

  factory BaldesModel.fromJson(Map<String, dynamic> json) {
    return BaldesModel(
      data: json['date'] != null ? DateTime.parse(json['date']) : null,
      total: json['total'] as int?,
      totalAbertos: json['openOrders'] as int?,
      emProgresso: json['inProgressOrders'] as int?,
      completos: json['completedOrders'] as int?,
      cancelados: json['canceledOrders'] as int?,
    );
  }

  @override
  String toString() {
    return 'BaldesModel(data: $data, total: $total, totalAbertos: $totalAbertos, emProgresso: $emProgresso, completos: $completos, cancelados: $cancelados)';
  }

  @override
  List<Object?> get props => [
        data,
        total,
        totalAbertos,
        emProgresso,
        completos,
        cancelados,
      ];
}
