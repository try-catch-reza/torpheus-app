class EapiSchema {
  static const String _apiUtils = '/api/';

  String get auth => '$_apiUtils/v1/auth/login';

  String adicionarPermissao(String id) => '$_apiUtils/v1/roles/$id';

  String get buscarClientes => '$_apiUtils/v1/client';

  String buscarClienteById(String id) => '$_apiUtils/v1/client/$id';

  String get buscarFuncionarios => '$_apiUtils/v1/employee';

  String get buscarVeiculos => '$_apiUtils/v1/vehicle';

  String get buscarUsuarios => '$_apiUtils/v1/user';

  String buscarEndereco(String cep) => '$_apiUtils/v1/address/$cep';

  String get buscarPerfis => '$_apiUtils/v1/roles';

  String buscarPerfilById(String id) => '$_apiUtils/v1/roles/$id';

  String buscarVeiculolById(String id) => '$_apiUtils/v1/vehicle/$id';

  String get cadastrarCliente => '$_apiUtils/v1/client';

  String get cadastrarFuncionario => '$_apiUtils/v1/employee';

  String get cadastrarPerfil => '$_apiUtils/v1/roles';

  String get cadastrarUsuario => '$_apiUtils/v1/user';

  String get cadastrarVeiculo => '$_apiUtils/v1/vehicle';

  String get catalogoPermissoes => '$_apiUtils/v1/roles/permissions/catalog';

  String excluirPerfilById(String id) => '$_apiUtils/v1/roles/$id';

  String updateCliente(String id) => '$_apiUtils/v1/client/$id';

  String updateVeiculo(String id) => '$_apiUtils/v1/vehicle/$id';

  String updateFuncionario(String id) => '$_apiUtils/v1/employee/$id';
}
