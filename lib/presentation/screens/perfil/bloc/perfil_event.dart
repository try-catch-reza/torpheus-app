part of 'perfil_bloc.dart';

sealed class PerfilEvent extends Equatable {
  const PerfilEvent();

  @override
  List<Object?> get props => [];
}

final class PerfilLoad extends PerfilEvent {
  const PerfilLoad();

  @override
  List<Object?> get props => [];
}