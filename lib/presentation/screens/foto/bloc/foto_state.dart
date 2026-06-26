part of 'foto_bloc.dart';

sealed class FotoState extends Equatable {
  const FotoState({
    this.fotosExistentes = const [],
    this.fotosNovas = const [],
    this.fotosNovasWeb = const [],
  });

  final List<FotoModel> fotosExistentes;
  final List<File> fotosNovas;
  final List<XFile> fotosNovasWeb;

  @override
  List<Object?> get props => [fotosExistentes, fotosNovas, fotosNovasWeb];
}

final class FotoInitial extends FotoState {
  const FotoInitial()
      : super(
          fotosExistentes: const [],
          fotosNovas: const [],
          fotosNovasWeb: const [],
        );
}

final class FotoLoading extends FotoState {
  const FotoLoading({
    required super.fotosExistentes,
    required super.fotosNovas,
    required super.fotosNovasWeb,
  });
}

final class FotoLoaded extends FotoState {
  const FotoLoaded({
    required super.fotosExistentes,
    required super.fotosNovas,
    required super.fotosNovasWeb,
  });

  @override
  List<Object?> get props => [fotosExistentes, fotosNovas, fotosNovasWeb];
}

final class FotoFail extends FotoState {
  const FotoFail(
    this.message, {
    required super.fotosExistentes,
    required super.fotosNovas,
    required super.fotosNovasWeb,
  });

  final String message;

  @override
  List<Object?> get props => [message, fotosExistentes, fotosNovas, fotosNovasWeb];
}

final class FotoUploadLoading extends FotoState {
  const FotoUploadLoading({
    required super.fotosExistentes,
    required super.fotosNovas,
    required super.fotosNovasWeb,
  });
}

final class FotoUploadSuccess extends FotoState {
  const FotoUploadSuccess({
    required super.fotosExistentes,
    required super.fotosNovas,
    required super.fotosNovasWeb,
  });
}

