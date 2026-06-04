class EapiSchema {
  static const String _apiUtils = '/api/';

  String get auth => '$_apiUtils/v1/auth/login';

  String get buscarCliente => '$_apiUtils/v1/client';

  String buscarClienteById(String id) => '$_apiUtils/v1/client/$id';

  String get buscarFuncionario => '$_apiUtils/v1/employee';

  String get buscarVeiculo => '$_apiUtils/v1/vehicle';

  String buscarEndereco(String cep) => '$_apiUtils/v1/address/$cep';

  String get buscarPerfis => '$_apiUtils/v1/roles';

  String buscarPerfilById(String id) => '$_apiUtils/v1/roles/$id';

  String get cadastrarCliente => '$_apiUtils/v1/client';

  String get cadastrarFuncionario => '$_apiUtils/v1/employee';

  String get cadastrarPerfil => '$_apiUtils/v1/roles';

  String get catalogoPermissoes => '$_apiUtils/v1/roles/permissions/catalog';

  String updateCliente(String id) => '$_apiUtils/v1/client/$id';
}
