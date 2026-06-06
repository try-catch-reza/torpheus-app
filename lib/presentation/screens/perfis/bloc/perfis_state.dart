import 'package:equatable/equatable.dart';

import '../../../../data/models/perfis_model.dart';
import '../../../../data/models/permissao_grupo_model.dart';

sealed class PerfisState extends Equatable {
  const PerfisState({
    this.perfis = const [],
    this.perfilSelecionado,
    this.permissaoGrupo = const [],
    this.catalogoPermissoes = const [],
    this.hasCriarPerfis = false,
    this.hasExcluirPerfis = false,
  });

  final List<PerfisModel> perfis;
  final PerfisModel? perfilSelecionado;
  final List<PermissaoGrupoModel> permissaoGrupo;
  final List<String> catalogoPermissoes;

  final bool hasCriarPerfis;
  final bool hasExcluirPerfis;

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
    required super.hasCriarPerfis,
    required super.hasExcluirPerfis,
    super.perfilSelecionado,
    super.permissaoGrupo,
    super.catalogoPermissoes,
  });

  @override
  List<Object?> get props => [
        perfis,
        hasCriarPerfis,
        perfilSelecionado,
        permissaoGrupo,
        catalogoPermissoes,
      ];
}

final class PerfisError extends PerfisState {
  const PerfisError({
    required this.message,
    required super.hasCriarPerfis,
    required super.hasExcluirPerfis,
    super.perfis,
    super.perfilSelecionado,
    super.permissaoGrupo,
  });

  final String message;

  @override
  List<Object?> get props => [
        message,
        perfis,
        perfilSelecionado,
        permissaoGrupo,
      ];
}

final class PerfisCriado extends PerfisState {
  const PerfisCriado({
    required super.hasCriarPerfis,
    required super.hasExcluirPerfis,
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

final class PerfisExcluido extends PerfisState {
  const PerfisExcluido();

  @override
  List<Object?> get props => [
        perfis,
        perfilSelecionado,
        permissaoGrupo,
      ];
}
