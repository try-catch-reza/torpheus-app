import 'package:torpheus/domain/repositories/preferenfeces/preferences_local_repository.dart';

class PermissaoController {
  final PreferencesLocalRepository _preferencesLocalRepository;

  PermissaoController(
    this._preferencesLocalRepository,
  );

  bool temPermissao(String permissao) {
    final permissoes = _preferencesLocalRepository.getListPermissions();

    return permissoes.contains(permissao);
  }

  bool get podeCriarUsuario => temPermissao('users.create');

  bool get podeLerUsuario => temPermissao('users.read');

  bool get podeAtualizarUsuario => temPermissao('users.update');

  bool get podeExcluirUsuario => temPermissao('users.delete');

  bool get podeAtribuirRoleUsuario => temPermissao('users.assign_role');

  bool get podeCriarCliente => temPermissao('clients.create');

  bool get podeLerCliente => temPermissao('clients.read');

  bool get podeAtualizarCliente => temPermissao('clients.update');

  bool get podeExcluirCliente => temPermissao('clients.delete');

  bool get podeCriarRole => temPermissao('roles.create');

  bool get podeLerRole => temPermissao('roles.read');

  bool get podeAtualizarRole => temPermissao('roles.update');

  bool get podeExcluirRole => temPermissao('roles.delete');

  bool get podeCriarFuncionario => temPermissao('employees.create');

  bool get podeLerFuncionario => temPermissao('employees.read');

  bool get podeAtualizarFuncionario => temPermissao('employees.update');

  bool get podeExcluirFuncionario => temPermissao('employees.delete');

  bool get podeCriarVeiculo => temPermissao('vehicles.create');

  bool get podeLerVeiculo => temPermissao('vehicles.read');

  bool get podeAtualizarVeiculo => temPermissao('vehicles.update');

  bool get podeExcluirVeiculo => temPermissao('vehicles.delete');

  bool get podeLerTenant => temPermissao('tenants.read');

  bool get podeAtualizarTenant => temPermissao('tenants.update');
}
