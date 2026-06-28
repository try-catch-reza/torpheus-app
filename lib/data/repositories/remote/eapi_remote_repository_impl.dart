import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:torpheus/core/constants/enum/granularidade.dart';
import 'package:torpheus/core/constants/enum/status_ordem.dart';
import 'package:torpheus/core/constants/enum/status_servico.dart';
import 'package:torpheus/data/models/auth_model.dart';
import 'package:torpheus/data/models/auth_response_model.dart';
import 'package:torpheus/data/models/cliente_model.dart';
import 'package:torpheus/data/models/endereco_model.dart';
import 'package:torpheus/data/models/funcionario_model.dart';
import 'package:torpheus/data/models/indicador_ordem_servico_model.dart';
import 'package:torpheus/data/models/indicador_ordem_servico_periodo_model.dart';
import 'package:torpheus/data/models/ordem_servico_model.dart';
import 'package:torpheus/data/models/perfis_model.dart';
import 'package:torpheus/data/models/servico_model.dart';
import 'package:torpheus/data/models/usuario_model.dart';
import 'package:torpheus/data/models/veiculo_model.dart';

import '../../../config/eapi_schema.dart';
import '../../../core/resources/base_remote_data_source.dart';
import '../../../domain/repositories/remote/eapi_remote_repository.dart';
import '../../datasources/remote/http_client.dart';

class EapiRemoteRepositoryImpl extends BaseRemoteDataSource
    implements EapiRemoteRepository {
  EapiRemoteRepositoryImpl(super.httpClient, this._schema);

  final EapiSchema _schema;

  @override
  Future<AuthResponseModel> auth(AuthModel authModel) async {
    const titleMessage = 'Não foi possível autenticar o usuário';

    return await post(
      path: _schema.auth,
      body: authModel.toJson(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return AuthResponseModel.fromJson(response.data);
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<List<ClienteModel>> getClientes() async {
    const titleMessage = 'Não foi possível carregar os clientes';

    return await get(
      path: _schema.buscarClientes,
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = response.data;
          final List<dynamic> items = data['items'] ?? [];

          return items.map((item) => ClienteModel.fromJson(item)).toList();
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<EnderecoModel> buscarEnderecoViaCep(String cep) async {
    const titleMessage = 'Não foi possível buscar o endereço';

    return await get(
      path: _schema.buscarEndereco(cep),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return EnderecoModel.fromJson(response.data);
        }
        if (response.statusCode == 404) {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'CEP não encontrado.',
            response: response,
          );
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> cadastrarCliente(ClienteModel cliente) async {
    const titleMessage = 'Não foi possível cadastrar o cliente';

    return await post(
      path: _schema.cadastrarCliente,
      body: cliente.toJson(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> cadastrarFuncionario(FuncionarioModel funcionario) async {
    const titleMessage = 'Não foi possível cadastrar o funcionário';

    return await post(
      path: _schema.cadastrarFuncionario,
      body: funcionario.toJson(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<List<FuncionarioModel>> getFuncionarios() async {
    const titleMessage = 'Não foi possível carregar os funcionários';

    return await get(
      path: _schema.buscarFuncionarios,
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = response.data;
          final List<dynamic> items = data['items'] ?? [];

          return items.map((item) => FuncionarioModel.fromJson(item)).toList();
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<ClienteModel> getClienteById(String id) async {
    const titleMessage = 'Não foi possível carregar os dados do cliente';

    return await get(
      path: _schema.buscarClienteById(id),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return ClienteModel.fromJson(response.data);
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> updateCliente(ClienteModel cliente, String id) async {
    const titleMessage = 'Não foi possível atualizar os dados do cliente';

    return await put(
      path: _schema.updateCliente(id),
      body: cliente.toJsonUpdate(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> cadastrarVeiculo(VeiculoModel veiculo) async {
    const titleMessage = 'Não foi possível buscar os veículos';

    await post(
      path: _schema.cadastrarVeiculo,
      body: veiculo.toJson(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<List<VeiculoModel>> getVeiculos() async {
    const titleMessage = 'Não foi possível carregar os dados do cliente';

    return await get(
      path: _schema.buscarVeiculos,
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = response.data;
          final List<dynamic> items = data['items'] ?? [];

          return items.map((item) => VeiculoModel.fromJson(item)).toList();
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> cadastrarPerfil(PerfisModel perfil) async {
    const titleMessage = 'Não foi possível criar novo perfil';

    await post(
      path: _schema.cadastrarPerfil,
      body: perfil.toJsonAPI(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<List<String>> getCatalogoPermissoes() async {
    const titleMessage = 'Não foi possível carregar o catálogo de permissões';

    return await get(
      path: _schema.catalogoPermissoes,
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return List<String>.from(response.data);
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<List<PerfisModel>> getPerfis() async {
    const titleMessage = 'Não foi possível carregar os perfis';

    return await get(
      path: _schema.buscarPerfis,
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = response.data;
          final List<dynamic> items = data['roles'] ?? [];

          return items.map((item) => PerfisModel.fromJson(item)).toList();
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<PerfisModel> getPerfilById(String id) async {
    const titleMessage = 'Não foi possível carregar os detalhes do perfil';

    return await get(
      path: _schema.buscarPerfilById(id),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return PerfisModel.fromJson(response.data);
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> adicionarPermissao(PerfisModel perfil) async {
    const titleMessage = 'Não foi possível adicionar essa permissão';

    await put(
      path: _schema.adicionarPermissao(perfil.id ?? ''),
      body: perfil.toJsonPUT(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return PerfisModel.fromJson(response.data);
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> cadastrarUsuario(UsuarioModel usuario) async {
    const titleMessage = 'Não foi possível salvar novo usuário';

    await post(
      path: _schema.cadastrarUsuario,
      body: usuario.toAPI(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<List<UsuarioModel>> getUsuarios() async {
    const titleMessage = 'Não foi possível carregar os usuários';

    return await get(
      path: _schema.buscarUsuarios,
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = response.data;
          final List<dynamic> items = data['users'] ?? [];

          return items.map((item) => UsuarioModel.fromJson(item)).toList();
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<VeiculoModel> getVeiculoById(String id) async {
    const titleMessage = 'Não foi possível carregar os detalhes do veículo';

    return await get(
      path: _schema.buscarVeiculolById(id),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return VeiculoModel.fromJson(response.data);
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> updateVeiculo(VeiculoModel veiculo) async {
    const titleMessage = 'Não foi possível atualizar esse veículo';

    await put(
      path: _schema.updateVeiculo(veiculo.id ?? ''),
      body: veiculo.toJsonPUT(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return PerfisModel.fromJson(response.data);
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> excluirPerfil(PerfisModel perfil) async {
    const titleMessage = 'Não foi possível excluir esse perfil';

    await delete(
      path: _schema.excluirPerfilById(perfil.id ?? ''),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 204) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> updateFuncionario(FuncionarioModel funcionario) async {
    const titleMessage = 'Não foi possível atualizar esse funcionário';

    await put(
      path: _schema.updateFuncionario(funcionario.id ?? ''),
      body: funcionario.toJsonPUT(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<FuncionarioModel> getFuncionarioById(String id) async {
    const titleMessage = 'Não foi possível carregar o funcionário';

    return await get(
      path: _schema.buscarFuncionarioById(id),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return FuncionarioModel.fromJson(response.data);
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<UsuarioModel> getUsuarioById(String id) async {
    const titleMessage = 'Não foi possível carregar o funcionário';

    return await get(
      path: _schema.buscarUsuarioById(id),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return UsuarioModel.fromJson(response.data);
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> abrirOS(OrdemServicoModel ordemServico) async {
    const titleMessage = 'Não foi possível abrir uma ordem de serviço';

    await post(
      path: _schema.abrirOS,
      body: ordemServico.toPOST(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> adicionarServico(ServicoModel servico, String id) async {
    const titleMessage = 'Não foi possível adicionar o serviço';

    await post(
      path: _schema.adicionarServico(id),
      body: servico.toPUTDescrAndFunc(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<List<OrdemServicoModel>> getOS() async {
    const titleMessage = 'Não foi possível carregar as ordens de serviço';

    return await get(
      path: _schema.buscarOS,
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = response.data;
          final List<dynamic> items = data['items'] ?? [];

          return items.map((item) => OrdemServicoModel.fromJson(item)).toList();
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<OrdemServicoModel> getOSById(String id) async {
    const titleMessage = 'Não foi possível carregar a ordem de serviço';

    return await get(
      path: _schema.buscarOSById(id),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return OrdemServicoModel.fromJson(response.data);
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> updateDescricaoAndMecanico(
    ServicoModel servico,
    String id,
  ) async {
    const titleMessage = 'Não foi possível atualizar o serviço';

    await put(
      path: _schema.updateDescrOurFuncOS(id, servico.id ?? ''),
      body: servico.toPUTDescrAndFunc(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> updateOS(OrdemServicoModel ordemServico) async {}

  @override
  Future<void> updateStatusOS(StatusOrdem status, String id) async {
    const titleMessage =
        'Não foi possível atualizar o status da ordem de serviço';

    await patch(
      path: _schema.updateStatusOS(id),
      body: {'status': status.value},
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> updateStatusServico(
    StatusServico status,
    String id,
    String servicoId,
  ) async {
    const titleMessage = 'Não foi possível atualizar o status do serviço';

    await patch(
      path: _schema.updateStatusServico(id, servicoId),
      titleMessage: titleMessage,
      body: {'status': status.value},
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> uploadFoto(
    String ordemServicoId,
    String servicoId,
    File file,
  ) async {
    const titleMessage = 'Não foi possível enviar a foto do serviço';

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    await post(
      path: _schema.anexarFoto(ordemServicoId, servicoId),
      body: formData,
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> uploadFotoXFile(
    String ordemServicoId,
    String servicoId,
    XFile xFile,
  ) async {
    const titleMessage = 'Não foi possível enviar a foto do serviço';

    final bytes = await xFile.readAsBytes();

    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        bytes,
        filename: xFile.name,
      ),
    });

    await post(
      path: _schema.anexarFoto(ordemServicoId, servicoId),
      body: formData,
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<void> registrarWorkLog({
    required String ordemServicoId,
    required String servicoId,
    required int durationMinutes,
    required DateTime performedAt,
    String? note,
  }) async {
    const titleMessage = 'Não foi possível registrar o trabalho';

    await post(
      path: _schema.registrarWorkLog(ordemServicoId, servicoId),
      body: {
        'durationMinutes': durationMinutes,
        'performedAt': performedAt.toIso8601String(),
        'note': note,
      },
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          return;
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<IndicadorOrdemServicoModel> getIndicadoresOrdensServico({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    const titleMessage = 'Não foi possível carregar os indicadores';

    return await get(
      path: _schema.reports,
      queryParameters: {
        'StartDate': startDate.toUtc().toIso8601String(),
        'EndDate': endDate.toUtc().toIso8601String(),
      },
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return IndicadorOrdemServicoModel.fromJson(response.data);
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }

  @override
  Future<IndicadorOrdemServicoPeriodoModel> getIndicadoresOrdensServicoPeriodo({
    required DateTime startDate,
    required DateTime endDate,
    required Granularidade granularidade,
  }) async {
    const titleMessage = 'Não foi possível carregar os indicadores por período';

    return await get(
      path: _schema.periodo,
      titleMessage: titleMessage,
      queryParameters: {
        'StartDate': startDate.toUtc().toIso8601String(),
        'EndDate': endDate.toUtc().toIso8601String(),
        'Granularity': granularidade.value.toString(),
      },
      response: (response) {
        if (response.statusCode == 200) {
          return IndicadorOrdemServicoPeriodoModel.fromJson(response.data);
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }
}
