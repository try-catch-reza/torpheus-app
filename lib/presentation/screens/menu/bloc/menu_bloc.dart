import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/repositories/preferenfeces/preferences_local_repository.dart';

part 'menu_event.dart';

part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  late final PreferencesLocalRepository _preferencesLocalRepository;

  MenuBloc(this._preferencesLocalRepository) : super(const MenuInitial()) {
    on<MenuCarregar>(_onMenuLoad);
    on<MenuTrocarTela>(_onMenuTrocarTela);
  }

  Future<void> _onMenuLoad(
    MenuCarregar event,
    Emitter<MenuState> emit,
  ) async {
    try {
      emit(const MenuLoading());

      final nome = _preferencesLocalRepository.getNome();

      emit(MenuLoaded(indexScreen: state.indexScreen, nome: nome));
    } catch (e) {
      emit(const MenuFail('Deu rim'));
    }
  }

  void _onMenuTrocarTela(
    MenuTrocarTela event,
    Emitter<MenuState> emit,
  ) {
    if (event.indexScreen == 5) {
      emit(MenuLoaded(indexScreen: 0, nome: state.nome));
    }

    emit(MenuLoaded(indexScreen: event.indexScreen, nome: state.nome));
  }
}
