import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/permissao_model.dart';

sealed class PerfisEvent extends Equatable {
  const PerfisEvent();

  @override
  List<Object?> get props => [];
}

final class PerfisLoad extends PerfisEvent {
  const PerfisLoad();

  @override
  List<Object?> get props => [];
}

final class PerfisSelect extends PerfisEvent {
  const PerfisSelect(this.perfilId);

  final String perfilId;

  @override
  List<Object?> get props => [perfilId];
}

final class PerfisCriar extends PerfisEvent {
  const PerfisCriar(this.nome);

  final String nome;

  @override
  List<Object?> get props => [nome];
}

final class PerfisAdicionarPermissao extends PerfisEvent {
  const PerfisAdicionarPermissao(this.permissao);

  final PermissaoModel permissao;

  @override
  List<Object?> get props => [permissao];
}
