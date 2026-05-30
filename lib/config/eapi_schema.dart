class EapiSchema {
  static const String _apiUtils = '/api/';

  String get auth => '$_apiUtils/v1/auth/login';

  String get buscarCliente => '$_apiUtils/v1/client';

  String buscarClienteById(String id) => '$_apiUtils/v1/client/$id';

  String get buscarFuncionario => '$_apiUtils/v1/employee';

  String buscarEndereco(String cep) => '$_apiUtils/v1/address/$cep';

  String get cadastrarCliente => '$_apiUtils/v1/client';

  String get cadastrarFuncionario => '$_apiUtils/v1/employee';

  String updateCliente(String id) => '$_apiUtils/v1/client/$id';
}
