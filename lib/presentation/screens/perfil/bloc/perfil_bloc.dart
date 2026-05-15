import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repositories/preferenfeces/preferences_local_repository.dart';

part 'perfil_event.dart';

part 'perfil_state.dart';

class PerfilBloc extends Bloc<PerfilEvent, PerfilState> {
  late final PreferencesLocalRepository _preferencesLocalRepository;

  PerfilBloc(this._preferencesLocalRepository) : super(const PerfilInitial()) {
    on<PerfilLoad>(_onPerfilLoad);
  }

  void _onPerfilLoad(PerfilEvent event, Emitter<PerfilState> emit) {
    emit(const PerfilLoading());

    final nome = _preferencesLocalRepository.getNome();
    final email = _preferencesLocalRepository.getEmail();

    emit(PerfilLoaded(email: email, nome: nome));
  }
}
