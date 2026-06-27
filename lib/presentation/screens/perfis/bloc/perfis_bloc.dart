import 'package:bloc/bloc.dart';
import 'package:torpheus/data/models/perfis_model.dart';
import 'package:torpheus/data/models/permissao_grupo_model.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_event.dart';

import '../../../../data/datasources/remote/http_client.dart';
import '../../../../data/models/permissao_model.dart';
import '../../../../domain/controller/permissao_controller.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

import 'perfis_state.dart';

class PerfisBloc extends Bloc<PerfisEvent, PerfisState> {
  late final EapiRemoteRepository _eapiRemoteRepository;
  late final PermissaoController _permissaoController;

  PerfisBloc(
    this._eapiRemoteRepository,
    this._permissaoController,
  ) : super(const PerfisInitial()) {
    on<PerfisLoad>(_onPerfisLoad);
    on<PerfisSelect>(_onPerfisSelect);
    on<PerfisCriar>(_onPerfisCriar);
    on<PerfisAdicionarPermissao>(_onPerfisAdicionarPermissao);
    on<PerfisExcluirPerfil>(_onPerfisExcluirPerfil);
  }

  Future<void> _onPerfisLoad(
    PerfisLoad event,
    Emitter<PerfisState> emit,
  ) async {
    emit(const PerfisLoading());

    try {
      final hasCriarPerfis = _permissaoController.podeCriarRole;
      final hasExcluirPerfis = _permissaoController.podeExcluirRole;
      final hasEditarPerfis = _permissaoController.podeAtualizarRole;

      final perfis = await _eapiRemoteRepository.getPerfis();
      emit(
        PerfisLoaded(
          hasAtualizarPerfis: hasEditarPerfis,
          perfis: perfis,
          hasCriarPerfis: hasCriarPerfis,
          hasExcluirPerfis: hasExcluirPerfis,
        ),
      );
    } on HttpRequestException catch (e) {
      emit(
        PerfisError(
          message: e.title,
          hasCriarPerfis: state.hasCriarPerfis,
          hasExcluirPerfis: state.hasExcluirPerfis,
        ),
      );
    } catch (e) {
      emit(
        PerfisError(
          message: 'Não foi possível carregar os perfis.\n$e',
          hasCriarPerfis: state.hasCriarPerfis,
          hasExcluirPerfis: state.hasExcluirPerfis,
        ),
      );
    }
  }

  Future<void> _onPerfisSelect(
    PerfisSelect event,
    Emitter<PerfisState> emit,
  ) async {
    try {
      final perfilSelecionado = await _eapiRemoteRepository.getPerfilById(
        event.perfilId,
      );

      final allPermissoes = await _eapiRemoteRepository.getCatalogoPermissoes();

      final userPermissoes = perfilSelecionado.permissoes;

      // Monta a lista de PermissaoModel marcando as que o perfil já tem
      final permissions = allPermissoes.map((valor) {
        return PermissaoModel.fromString(valor).copyWith(
          isSelected: userPermissoes?.contains(valor),
        );
      }).toList();

      // Agrupa por recurso para exibir na UI
      final permissionGroup = _agruparPermissoes(permissions);

      final hasExcluirPefis =
          state.hasExcluirPerfis && !perfilSelecionado.isSystem!;

      emit(
        PerfisLoaded(
          perfis: state.perfis,
          perfilSelecionado: perfilSelecionado,
          permissaoGrupo: permissionGroup,
          catalogoPermissoes: allPermissoes,
          hasCriarPerfis: state.hasCriarPerfis,
          hasExcluirPerfis: hasExcluirPefis,
          hasAtualizarPerfis: state.hasAtualizarPerfis
        ),
      );
    } catch (e) {
      emit(
        PerfisError(
          message: 'Não foi possível carregar os detalhes do perfil.\n$e',
          hasCriarPerfis: state.hasCriarPerfis,
          hasExcluirPerfis: state.hasExcluirPerfis,
        ),
      );
    }
  }

  Future<void> _onPerfisCriar(
    PerfisCriar event,
    Emitter<PerfisState> emit,
  ) async {
    try {
      final perfisNovo = PerfisModel(
        permissoes: const [],
        nome: event.nome,
        isActive: true,
      );

      await _eapiRemoteRepository.cadastrarPerfil(perfisNovo);

      emit(
        PerfisCriado(
          hasCriarPerfis: state.hasCriarPerfis,
          hasExcluirPerfis: state.hasExcluirPerfis,
        ),
      );
    } on HttpRequestException catch (e) {
      emit(
        PerfisError(
          message: e.message,
          permissaoGrupo: state.permissaoGrupo,
          perfilSelecionado: state.perfilSelecionado,
          perfis: state.perfis,
          hasCriarPerfis: state.hasCriarPerfis,
          hasExcluirPerfis: state.hasExcluirPerfis,
        ),
      );
    } catch (e) {
      emit(
        PerfisError(
          message: 'Não foi possível criar o perfil.\n$e',
          permissaoGrupo: state.permissaoGrupo,
          perfilSelecionado: state.perfilSelecionado,
          perfis: state.perfis,
          hasCriarPerfis: state.hasCriarPerfis,
          hasExcluirPerfis: state.hasExcluirPerfis,
        ),
      );
    }
  }

  Future<void> _onPerfisAdicionarPermissao(
    PerfisAdicionarPermissao event,
    Emitter<PerfisState> emit,
  ) async {
    try {
      final perfilSelecionado = await _eapiRemoteRepository.getPerfilById(
        state.perfilSelecionado?.id ?? '',
      );

      if (perfilSelecionado.permissoes!.contains(event.permissao.valor)) {
        perfilSelecionado.permissoes?.remove(event.permissao.valor);
      } else {
        perfilSelecionado.permissoes?.add(event.permissao.valor);
      }

      await _eapiRemoteRepository.adicionarPermissao(perfilSelecionado);

      final perfilAtualizado = await _eapiRemoteRepository.getPerfilById(
        state.perfilSelecionado?.id ?? '',
      );

      final userPermissoes = perfilAtualizado.permissoes;

      // Monta a lista de PermissaoModel marcando as que o perfil já tem
      final permissions = state.catalogoPermissoes.map((valor) {
        return PermissaoModel.fromString(valor).copyWith(
          isSelected: userPermissoes?.contains(valor),
        );
      }).toList();

      // Agrupa por recurso para exibir na UI
      final permissionGroup = _agruparPermissoes(permissions);

      emit(
        PerfisLoaded(
          perfis: state.perfis,
          perfilSelecionado: perfilAtualizado,
          permissaoGrupo: permissionGroup,
          catalogoPermissoes: state.catalogoPermissoes,
          hasCriarPerfis: state.hasCriarPerfis,
          hasExcluirPerfis: state.hasExcluirPerfis,
          hasAtualizarPerfis: state.hasAtualizarPerfis
        ),
      );
    } on HttpRequestException catch (e) {
      emit(
        PerfisError(
          message: e.message,
          permissaoGrupo: state.permissaoGrupo,
          perfilSelecionado: state.perfilSelecionado,
          perfis: state.perfis,
          hasCriarPerfis: state.hasCriarPerfis,
          hasExcluirPerfis: state.hasExcluirPerfis,
        ),
      );
    } catch (e) {
      emit(
        PerfisError(
          message: 'Não foi possível criar o perfil.\n$e',
          permissaoGrupo: state.permissaoGrupo,
          perfilSelecionado: state.perfilSelecionado,
          perfis: state.perfis,
          hasCriarPerfis: state.hasCriarPerfis,
          hasExcluirPerfis: state.hasExcluirPerfis,
        ),
      );
    }
  }

  Future<void> _onPerfisExcluirPerfil(
    PerfisExcluirPerfil event,
    Emitter<PerfisState> emit,
  ) async {
    try {
      await _eapiRemoteRepository.excluirPerfil(event.perfis);

      emit(const PerfisExcluido());
    } on HttpRequestException catch (e) {
      emit(
        PerfisError(
          message: e.message,
          permissaoGrupo: state.permissaoGrupo,
          perfilSelecionado: state.perfilSelecionado,
          perfis: state.perfis,
          hasCriarPerfis: state.hasCriarPerfis,
          hasExcluirPerfis: state.hasExcluirPerfis,
        ),
      );
    } catch (e) {
      emit(
        PerfisError(
          message: 'Não foi possível criar o perfil.\n$e',
          permissaoGrupo: state.permissaoGrupo,
          perfilSelecionado: state.perfilSelecionado,
          perfis: state.perfis,
          hasCriarPerfis: state.hasCriarPerfis,
          hasExcluirPerfis: state.hasExcluirPerfis,
        ),
      );
    }
  }

  List<PermissaoGrupoModel> _agruparPermissoes(
    List<PermissaoModel> permissions,
  ) {
    final Map<String, List<PermissaoModel>> mapa = {};

    for (final p in permissions) {
      mapa.putIfAbsent(p.recurso, () => []).add(p);
    }

    final titulos = {
      'users': 'Usuários',
      'clients': 'Clientes',
      'roles': 'Perfis',
      'employees': 'Funcionários',
      'tenants': 'Empresas',
      'vehicles': 'Veículos',
      'service_orders': 'Ordens de Serviço',
    };

    return mapa.entries.map((entry) {
      return PermissaoGrupoModel(
        recurso: entry.key,
        titulo: titulos[entry.key] ?? entry.key,
        itens: entry.value,
      );
    }).toList();
  }
}
