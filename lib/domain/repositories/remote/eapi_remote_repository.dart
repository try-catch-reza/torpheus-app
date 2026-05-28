import 'package:torpheus/data/models/cliente_model.dart';

import '../../../data/models/auth_model.dart';
import '../../../data/models/auth_response_model.dart';
import '../../../data/models/endereco_model.dart';

abstract class EapiRemoteRepository {
  /// Autenticação -------------------------------------------------------------
  Future<AuthResponseModel> auth(AuthModel authModel);

  /// Clientes -----------------------------------------------------------------
  Future<List<ClienteModel>> getClientes();

  Future<void> cadastrarCliente(ClienteModel cliente);

  /// VIA CEP ------------------------------------------------------------------
  Future<EnderecoModel> buscarEnderecoViaCep(String cep);
}
