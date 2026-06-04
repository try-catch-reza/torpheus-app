import 'package:bloc/bloc.dart';
import 'package:torpheus/data/models/perfis_model.dart';
import 'package:torpheus/data/models/permissao_grupo_model.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_event.dart';

import '../../../../data/datasources/remote/http_client.dart';
import '../../../../data/models/permissao_model.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

import 'perfis_state.dart';

class PerfisBloc extends Bloc<PerfisEvent, PerfisState> {
  final EapiRemoteRepository _eapiRemoteRepository;

  PerfisBloc(this._eapiRemoteRepository) : super(const PerfisInitial()) {
    on<PerfisLoad>(_onPerfisLoad);
    on<PerfisSelect>(_onPerfisSelect);
    on<PerfisCriar>(_onPerfisCriar);
  }

  Future<void> _onPerfisLoad(
    PerfisLoad event,
    Emitter<PerfisState> emit,
  ) async {
    emit(const PerfisLoading());

    try {
      final perfis = await _eapiRemoteRepository.getPerfis();
      emit(PerfisLoaded(perfis: perfis));
    } on HttpRequestException catch (e) {
      emit(PerfisError(message: e.title));
    } catch (e) {
      emit(PerfisError(message: 'Não foi possível carregar os perfis.\n$e'));
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

      emit(
        PerfisLoaded(
          perfis: state.perfis,
          perfilSelecionado: perfilSelecionado,
          permissaoGrupo: permissionGroup,
        ),
      );
    } catch (e) {
      emit(
        PerfisError(
          message: 'Não foi possível carregar os detalhes do perfil.\n$e',
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
      );

      await _eapiRemoteRepository.cadastrarPerfil(perfisNovo);

      emit(const PerfisCriado());
    } on HttpRequestException catch (e) {
      emit(
        PerfisError(
          message: e.message,
        ),
      );
    } catch (e) {
      emit(
        PerfisError(
          message: 'Não foi possível criar o perfil.\n$e',
        ),
      );
    }
  }

  List<PermissaoGrupoModel> _agruparPermissoes(
      List<PermissaoModel> permissions) {
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
