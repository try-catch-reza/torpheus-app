import 'package:torpheus/data/models/auth_model.dart';
import 'package:torpheus/data/models/auth_response_model.dart';
import 'package:torpheus/data/models/cliente_model.dart';
import 'package:torpheus/data/models/endereco_model.dart';
import 'package:torpheus/data/models/mecanico_model.dart';

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
      path: _schema.buscarCliente,
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
      path: _schema.buscarFuncionario,
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
}
