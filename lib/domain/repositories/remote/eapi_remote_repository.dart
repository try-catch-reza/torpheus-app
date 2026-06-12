import 'package:torpheus/data/models/cliente_model.dart';
import 'package:torpheus/data/models/funcionario_model.dart';
import 'package:torpheus/data/models/usuario_model.dart';

import '../../../data/models/auth_model.dart';
import '../../../data/models/auth_response_model.dart';
import '../../../data/models/endereco_model.dart';
import '../../../data/models/perfis_model.dart';
import '../../../data/models/veiculo_model.dart';

abstract class EapiRemoteRepository {
  /// Autenticação -------------------------------------------------------------
  Future<AuthResponseModel> auth(AuthModel authModel);

  /// Clientes -----------------------------------------------------------------
  Future<List<ClienteModel>> getClientes();

  Future<void> cadastrarCliente(ClienteModel cliente);

  Future<ClienteModel> getClienteById(String id);

  Future<void> updateCliente(ClienteModel cliente, String id);

  /// VIA CEP ------------------------------------------------------------------
  Future<EnderecoModel> buscarEnderecoViaCep(String cep);

  /// Funcionários -------------------------------------------------------------
  Future<List<FuncionarioModel>> getFuncionarios();

  Future<void> cadastrarFuncionario(FuncionarioModel funcionario);

  Future<void> updateFuncionario(FuncionarioModel funcionario);

  Future<FuncionarioModel> getFuncionarioById(String id);

  /// Veículos -----------------------------------------------------------------
  Future<List<VeiculoModel>> getVeiculos();

  Future<void> cadastrarVeiculo(VeiculoModel veiculo);

  Future<void> updateVeiculo(VeiculoModel veiculo);

  Future<VeiculoModel> getVeiculoById(String id);

  /// Catálogo Permissões ------------------------------------------------------
  Future<List<String>> getCatalogoPermissoes();

  /// Perfis -------------------------------------------------------------------
  Future<List<PerfisModel>> getPerfis();

  Future<void> cadastrarPerfil(PerfisModel perfil);

  Future<PerfisModel> getPerfilById(String id);

  Future<void> adicionarPermissao(PerfisModel perfil);

  Future<void> excluirPerfil(PerfisModel perfil);

  /// Usuário ------------------------------------------------------------------
  Future<void> cadastrarUsuario(UsuarioModel usuario);

  Future<List<UsuarioModel>> getUsuarios();

  Future<UsuarioModel> getUsuarioById(String id);
}
