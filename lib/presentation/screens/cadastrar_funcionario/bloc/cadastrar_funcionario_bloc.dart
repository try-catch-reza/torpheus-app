import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/core/constants/enum/documento_tipo.dart';
import 'package:torpheus/core/constants/enum/funcao.dart';
import 'package:torpheus/data/models/funcionario_model.dart';
import 'package:torpheus/data/models/usuario_model.dart';

import '../../../../data/datasources/remote/http_client.dart';
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
    on<CadastrarFuncionarioSetAtivo>(_onCadastrarFuncionarioSetAtivo);
    on<CadastrarFuncionarioUpdate>(_onCadastrarFuncionarioAtualizar);
  }

  Future<void> _onCadastrarFuncionarioLoad(
    CadastrarFuncionarioLoad event,
    Emitter<CadastrarFuncionarioState> emit,
  ) async {
    emit(const CadastrarFuncionarioLoading());

    final usuarios = await _eapiRemoteRepository.getUsuarios();

    if (event.id != null) {
      final funcionario = await _eapiRemoteRepository.getFuncionarioById(
        event.id!,
      );

      final usuarioFunc = await _eapiRemoteRepository.getUsuarioById(
        funcionario.userId!,
      );

      emit(
        CadastrarFuncionarioLoaded(
          usuarios: usuarios,
          funcionario: funcionario,
          usuarioSelecionado: usuarioFunc,
          funcaoSelecionada: funcionario.funcao,
        ),
      );
      return;
    }

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
        funcao: state.funcaoSelecionada,
        documento: event.documento,
        telefone: event.telefone,
        userId: state.usuarioSelecionado?.id,
        documentType: DocumentoTipo.cpf,
        isActive: true,
      );

      await _eapiRemoteRepository.cadastrarFuncionario(funcionario);

      emit(const CadastrarFuncionarioSuccess());
    } on HttpRequestException catch (e) {
      emit(CadastrarFuncionarioError(e.message));
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
        funcionario: state.funcionario,
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
        funcionario: state.funcionario,
      ),
    );
  }

  Future<void> _onCadastrarFuncionarioAtualizar(
    CadastrarFuncionarioUpdate event,
    Emitter<CadastrarFuncionarioState> emit,
  ) async {
    try {
      emit(
        CadastrarFuncionarioLoading(
          funcaoSelecionada: state.funcaoSelecionada,
          funcionario: state.funcionario,
        ),
      );

      final funcionario = FuncionarioModel(
        id: state.funcionario?.id,
        nome: event.nome,
        funcao: state.funcaoSelecionada,
        documento: event.documento,
        telefone: event.telefone,
        documentType: DocumentoTipo.cpf,
        isActive: state.funcionario?.isActive,
      );

      await _eapiRemoteRepository.updateFuncionario(funcionario);

      emit(CadastrarFuncionarioAtualizado(funcionario: funcionario));
    } on HttpRequestException catch (e) {
      emit(CadastrarFuncionarioError(e.message));
    } catch (e) {
      emit(
        CadastrarFuncionarioError(
          'Não foi possível cadastrar o mecânico.\n$e',
        ),
      );
    }
  }

  void _onCadastrarFuncionarioSetAtivo(
    CadastrarFuncionarioSetAtivo event,
    Emitter<CadastrarFuncionarioState> emit,
  ) {
    final funcionarioAtualizado = state.funcionario?.copyWith(
      isActive: state.funcionario?.isActive == true ? false : true,
    );

    emit(
      CadastrarFuncionarioLoaded(
        funcaoSelecionada: state.funcaoSelecionada,
        usuarios: state.usuarios,
        usuarioSelecionado: state.usuarioSelecionado,
        funcionario: funcionarioAtualizado,
      ),
    );
  }
}
