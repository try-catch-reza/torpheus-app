part of 'foto_bloc.dart';

sealed class FotoEvent extends Equatable {
  const FotoEvent();

  @override
  List<Object?> get props => [];
}

final class FotoCarregar extends FotoEvent {
  const FotoCarregar({this.fotosExistentes = const []});

  final List<FotoModel> fotosExistentes;

  @override
  List<Object?> get props => [fotosExistentes];
}

final class FotoTirarFoto extends FotoEvent {
  const FotoTirarFoto();
}

final class FotoSelecionarGaleria extends FotoEvent {
  const FotoSelecionarGaleria();
}

final class FotoAdicionarArquivosWeb extends FotoEvent {
  const FotoAdicionarArquivosWeb();
}

final class FotoRemoverFotoNova extends FotoEvent {
  const FotoRemoverFotoNova(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

final class FotoRemoverFotoExistente extends FotoEvent {
  const FotoRemoverFotoExistente(this.foto);

  final FotoModel foto;

  @override
  List<Object?> get props => [foto];
}

final class FotoRemoverFotoWeb extends FotoEvent {
  const FotoRemoverFotoWeb(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

final class FotoEnviarFotos extends FotoEvent {
  const FotoEnviarFotos({
    required this.ordemServicoId,
    required this.servicoId,
  });

  final String ordemServicoId;
  final String servicoId;

  @override
  List<Object?> get props => [ordemServicoId, servicoId];
}

