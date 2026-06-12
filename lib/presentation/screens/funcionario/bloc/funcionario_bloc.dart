import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/datasources/remote/http_client.dart';
import '../../../../core/constants/enum/documento_tipo.dart';
import '../../../../core/constants/enum/funcao.dart';
import '../../../../data/models/funcionario_model.dart';
import '../../../../data/models/usuario_model.dart';
import '../../../../domain/controller/permissao_controller.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'funcionario_event.dart';

part 'funcionario_state.dart';

class FuncionarioBloc extends Bloc<FuncionarioEvent, FuncionarioState> {
  late final EapiRemoteRepository _eapiRemoteRepository;
  late final PermissaoController _permissaoController;

  FuncionarioBloc(
    this._eapiRemoteRepository,
    this._permissaoController,
  ) : super(const FuncionarioInitial()) {
    on<FuncionarioLoad>(_onFuncionarioLoad);
    on<FuncionarioSearch>(_onFuncionarioSearch);
    on<FuncionarioSetUsuario>(_onFuncionarioSetUsuario);
    on<FuncionarioSetFuncao>(_onFuncionarioSetFuncao);
    on<FuncionarioSubmit>(_onFuncionarioSubmit);
    on<FuncionarioUpdate>(_onFuncionarioUpdate);
    on<FuncionarioSetAtivo>(_onFuncionarioSetAtivo);
    on<FuncionarioSetUpdate>(_onFuncionarioSetUpdate);
  }

  Future<void> _onFuncionarioLoad(
    FuncionarioLoad event,
    Emitter<FuncionarioState> emit,
  ) async {
    emit(const FuncionarioLoading());
    try {
      final funcionarios = await _eapiRemoteRepository.getFuncionarios();
      final hasCriarFuncionario = _permissaoController.podeCriarFuncionario;
      final hasEditarFuncionario =
          _permissaoController.podeAtualizarFuncionario;
      final usuarios = await _eapiRemoteRepository.getUsuarios();

      emit(
        FuncionarioLoaded(
          funcionarios: funcionarios,
          funcionariosFiltered: funcionarios,
          hasCriarFuncionario: hasCriarFuncionario,
          usuarios: usuarios,
          hasEditarFuncionario: hasEditarFuncionario,
        ),
      );
    } on HttpRequestException catch (e) {
      emit(FuncionarioErrorInicial(e.title));
    } catch (e) {
      emit(FuncionarioErrorInicial(e.toString()));
    }
  }

  void _onFuncionarioSearch(
    FuncionarioSearch event,
    Emitter<FuncionarioState> emit,
  ) {
    List<FuncionarioModel> funcionariosFiltered = [];

    if (event.search.isNotEmpty) {
      final search = event.search.toLowerCase().trim();
      funcionariosFiltered = state.funcionarios.where((f) {
        final nome = f.nome?.toLowerCase() ?? '';

        return nome.contains(search);
      }).toList();
    } else {
      funcionariosFiltered = state.funcionarios;
    }

    emit(
      FuncionarioLoaded(
        funcionarios: state.funcionarios,
        funcionariosFiltered: funcionariosFiltered,
        hasCriarFuncionario: state.hasCriarFuncionario,
        search: event.search,
        hasEditarFuncionario: state.hasEditarFuncionario,
      ),
    );
  }

  void _onFuncionarioSetFuncao(
    FuncionarioSetFuncao event,
    Emitter<FuncionarioState> emit,
  ) {
    emit(
      FuncionarioLoaded(
        funcaoSelecionada: event.funcao,
        usuarios: state.usuarios,
        usuarioSelecionado: state.usuarioSelecionado,
        funcionarios: state.funcionarios,
        funcionariosFiltered: state.funcionariosFiltered,
        hasCriarFuncionario: state.hasCriarFuncionario,
        hasEditarFuncionario: state.hasEditarFuncionario,
      ),
    );
  }

  void _onFuncionarioSetUsuario(
    FuncionarioSetUsuario event,
    Emitter<FuncionarioState> emit,
  ) {
    emit(
      FuncionarioLoaded(
        funcaoSelecionada: state.funcaoSelecionada,
        usuarios: state.usuarios,
        usuarioSelecionado: event.usuario,
        funcionarios: state.funcionarios,
        funcionariosFiltered: state.funcionariosFiltered,
        hasCriarFuncionario: state.hasCriarFuncionario,
        hasEditarFuncionario: state.hasEditarFuncionario,
      ),
    );
  }

  Future<void> _onFuncionarioSubmit(
    FuncionarioSubmit event,
    Emitter<FuncionarioState> emit,
  ) async {
    try {
      emit(
        FuncionarioLoading(
          usuarioSelecionado: state.usuarioSelecionado,
          funcaoSelecionada: state.funcaoSelecionada,
          hasCriarFuncionario: state.hasCriarFuncionario,
          funcionariosFiltered: state.funcionariosFiltered,
          funcionarios: state.funcionarios,
          usuarios: state.usuarios,
          hasEditarFuncionario: state.hasEditarFuncionario,
        ),
      );

      final funcionario = FuncionarioModel(
        nome: event.nome,
        funcao: state.funcaoSelecionada,
        documento: event.documento,
        telefone: event.telefone,
        userId: state.usuarioSelecionado?.id,
        documentType: DocumentoTipo.cpf,
      );

      await _eapiRemoteRepository.cadastrarFuncionario(funcionario);
      emit(const FuncionarioSalvo());
    } on HttpRequestException catch (e) {
      emit(FuncionarioError(e.title));
    } catch (e) {
      emit(
        FuncionarioError(
          'Não foi possível cadastrar o mecânico.\n$e',
        ),
      );
    }
  }

  FutureOr<void> _onFuncionarioUpdate(
    FuncionarioUpdate event,
    Emitter<FuncionarioState> emit,
  ) async {
    try {
      emit(
        FuncionarioAtualizando(
          usuarioSelecionado: state.usuarioSelecionado,
          funcaoSelecionada: state.funcaoSelecionada,
          hasCriarFuncionario: state.hasCriarFuncionario,
          funcionariosFiltered: state.funcionariosFiltered,
          funcionarios: state.funcionarios,
          usuarios: state.usuarios,
          hasEditarFuncionario: state.hasEditarFuncionario,
          funcionarioEditar: state.funcionarioEditar,
        ),
      );

      final funcionario = FuncionarioModel(
        id: state.funcionarioEditar?.id,
        documentType: DocumentoTipo.cpf,
        isActive: state.funcionarioEditar?.isActive,
        nome: event.nome,
        documento: event.documento,
        telefone: event.telefone,
        funcao: state.funcaoSelecionada,
      );

      await _eapiRemoteRepository.updateFuncionario(funcionario);
      emit(const FuncionarioAtualizado());
    } on HttpRequestException catch (e) {
      emit(FuncionarioError(e.title));
    } catch (e) {
      emit(FuncionarioError('Não foi possível atualizar o veículo.\n$e'));
    }
  }

  void _onFuncionarioSetAtivo(
    FuncionarioSetAtivo event,
    Emitter<FuncionarioState> emit,
  ) {
    final funcionarioEditar = state.funcionarioEditar?.copyWith(
      isActive: state.funcionarioEditar?.isActive == true ? false : true,
    );

    emit(
      FuncionarioLoaded(
        funcaoSelecionada: state.funcaoSelecionada,
        usuarios: state.usuarios,
        usuarioSelecionado: state.usuarioSelecionado,
        funcionarios: state.funcionarios,
        funcionariosFiltered: state.funcionariosFiltered,
        hasCriarFuncionario: state.hasCriarFuncionario,
        hasEditarFuncionario: state.hasEditarFuncionario,
        funcionarioEditar: funcionarioEditar,
      ),
    );
  }

  void _onFuncionarioSetUpdate(
    FuncionarioSetUpdate event,
    Emitter<FuncionarioState> emit,
  ) {
    emit(
      FuncionarioLoaded(
        funcaoSelecionada: event.funcionario.funcao,
        usuarios: state.usuarios,
        usuarioSelecionado: state.usuarioSelecionado,
        funcionarios: state.funcionarios,
        funcionariosFiltered: state.funcionariosFiltered,
        hasCriarFuncionario: state.hasCriarFuncionario,
        hasEditarFuncionario: state.hasEditarFuncionario,
        funcionarioEditar: event.funcionario,
      ),
    );
  }
}
