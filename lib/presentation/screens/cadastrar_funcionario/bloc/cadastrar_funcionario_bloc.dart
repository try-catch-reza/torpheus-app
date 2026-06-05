import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/core/constants/enum/documento_tipo.dart';
import 'package:torpheus/core/constants/enum/funcao.dart';
import 'package:torpheus/data/models/funcionario_model.dart';
import 'package:torpheus/data/models/usuario_model.dart';

import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'cadastrar_funcionario_event.dart';

part 'cadastrar_funcionario_state.dart';

class CadastrarFuncionarioBloc
    extends Bloc<CadastrarFuncionarioEvent, CadastrarFuncionarioState> {
  late final EapiRemoteRepository _eapiRemoteRepository;

  CadastrarFuncionarioBloc(
    this._eapiRemoteRepository,
  ) : super(const CadastrarFuncionarioInitial()) {
    on<CadastrarFuncionarioLoad>(_onCadastrarFuncionarioLoad);
    on<CadastrarFuncionarioSubmit>(_onCadastrarFuncionarioSubmit);
    on<CadastrarFuncionarioSetFuncao>(_onCadastrarFuncionarioSetFuncao);
    on<CadastrarFuncionarioSetUsuario>(_onCadastrarFuncionarioSetUsuario);
  }

  Future<void> _onCadastrarFuncionarioLoad(
    CadastrarFuncionarioLoad event,
    Emitter<CadastrarFuncionarioState> emit,
  ) async {
    emit(const CadastrarFuncionarioLoading());

    final usuarios = await _eapiRemoteRepository.getUsuarios();

    emit(CadastrarFuncionarioLoaded(usuarios: usuarios));
  }

  Future<void> _onCadastrarFuncionarioSubmit(
    CadastrarFuncionarioSubmit event,
    Emitter<CadastrarFuncionarioState> emit,
  ) async {
    try {
      emit(
        CadastrarFuncionarioLoading(
          usuarioSelecionado: state.usuarioSelecionado,
          funcaoSelecionada: state.funcaoSelecionada,
        ),
      );

      final funcionario = FuncionarioModel(
        nome: event.nome,
        funcao: state.funcaoSelecionada?.label,
        documento: event.documento,
        telefone: event.telefone,
        userId: state.usuarioSelecionado?.id,
        documentType: DocumentoTipo.cpf,
      );

      await _eapiRemoteRepository.cadastrarFuncionario(funcionario);

      emit(const CadastrarFuncionarioSuccess());
    } catch (e) {
      emit(
        CadastrarFuncionarioError(
          'Não foi possível cadastrar o mecânico.\n$e',
        ),
      );
    }
  }

  void _onCadastrarFuncionarioSetFuncao(
    CadastrarFuncionarioSetFuncao event,
    Emitter<CadastrarFuncionarioState> emit,
  ) {
    emit(
      CadastrarFuncionarioLoaded(
        funcaoSelecionada: event.funcao,
        usuarios: state.usuarios,
        usuarioSelecionado: state.usuarioSelecionado,
      ),
    );
  }

  void _onCadastrarFuncionarioSetUsuario(
    CadastrarFuncionarioSetUsuario event,
    Emitter<CadastrarFuncionarioState> emit,
  ) {
    emit(
      CadastrarFuncionarioLoaded(
        funcaoSelecionada: state.funcaoSelecionada,
        usuarios: state.usuarios,
        usuarioSelecionado: event.usuario,
      ),
    );
  }
}
