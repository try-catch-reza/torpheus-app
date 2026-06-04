import 'package:equatable/equatable.dart';

import '../../../../data/models/perfis_model.dart';
import '../../../../data/models/permissao_grupo_model.dart';

sealed class PerfisState extends Equatable {
  const PerfisState({
    this.perfis = const [],
    this.perfilSelecionado,
    this.permissaoGrupo = const [],
  });

  final List<PerfisModel> perfis;
  final PerfisModel? perfilSelecionado;
  final List<PermissaoGrupoModel> permissaoGrupo;

  @override
  List<Object?> get props => [];
}

final class PerfisInitial extends PerfisState {
  const PerfisInitial();
}

final class PerfisLoading extends PerfisState {
  const PerfisLoading();
}

final class PerfisLoaded extends PerfisState {
  const PerfisLoaded({
    required super.perfis,
    super.perfilSelecionado,
    super.permissaoGrupo,
  });

  @override
  List<Object?> get props => [
        perfis,
        perfilSelecionado,
        permissaoGrupo,
      ];
}

final class PerfisError extends PerfisState {
  const PerfisError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

final class PerfisCriado extends PerfisState {
  const PerfisCriado({
    super.perfis,
    super.perfilSelecionado,
    super.permissaoGrupo,
  });

  @override
  List<Object?> get props => [
        perfis,
        perfilSelecionado,
        permissaoGrupo,
      ];
}
