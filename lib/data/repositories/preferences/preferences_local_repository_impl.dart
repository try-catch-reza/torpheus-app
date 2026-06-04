import '../../../core/constants/enum/preferences.dart';
import '../../../domain/repositories/preferenfeces/preferences_local_repository.dart';
import '../../datasources/local/shared_data.dart';

class PreferencesLocalRepositoryImpl extends PreferencesLocalRepository {
  PreferencesLocalRepositoryImpl(this._sharedData);

  final SharedData _sharedData;

  @override
  String? getAccessToken() {
    return _sharedData.getValue<String>(Preferences.accessToken);
  }

  @override
  String? getRefreshToken() {
    return _sharedData.getValue<String>(Preferences.refreshToken);
  }

  @override
  Future<void> removeAccessToken() async {
    await _sharedData.cleanValue(Preferences.accessToken);
  }

  @override
  Future<void> removeRefreshToken() async {
    await _sharedData.cleanValue(Preferences.refreshToken);
  }

  @override
  Future<void> saveAccessToken(String acessToken) async {
    await _sharedData.setValue(Preferences.accessToken, acessToken);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await _sharedData.setValue(Preferences.refreshToken, refreshToken);
  }

  @override
  bool getIsUsuarioLogado() {
    return _sharedData.getValue<bool>(Preferences.isUsuarioLogado) ?? false;
  }

  @override
  Future<void> removeIsUsuarioLogado() async {
    await _sharedData.cleanValue(Preferences.isUsuarioLogado);
  }

  @override
  Future<void> saveIsUsuarioLogado(bool value) async {
    await _sharedData.setValue(Preferences.isUsuarioLogado, value);
  }

  @override
  List<String> getListPermissions() {
    return _sharedData.getValue<List<String>>(Preferences.permissions) ?? [];
  }

  @override
  Future<void> removeListPermisions() async {
    await _sharedData.cleanValue(Preferences.permissions);
  }

  @override
  Future<void> saveListPermissions(List<String> value) async {
    await _sharedData.setValue(Preferences.permissions, value);
  }

  @override
  String getEmail() {
    return _sharedData.getValue<String>(Preferences.email) ?? '';
  }

  @override
  String getNome() {
    return _sharedData.getValue<String>(Preferences.nome) ?? '';
  }

  @override
  Future<void> removeEmail() async {
    await _sharedData.cleanValue(Preferences.email);
  }

  @override
  Future<void> removeNome() async {
    await _sharedData.cleanValue(Preferences.nome);
  }

  @override
  Future<void> saveEmail(String value) async {
    await _sharedData.setValue(Preferences.email, value);
  }

  @override
  Future<void> saveNome(String value) async {
    await _sharedData.setValue(Preferences.nome, value);
  }

  @override
  String getCargo() {
    return _sharedData.getValue<String>(Preferences.cargo) ?? '';
  }

  @override
  Future<void> removeCargo() async {
    await _sharedData.cleanValue(Preferences.cargo);
  }

  @override
  Future<void> saveCargo(String value) async {
    await _sharedData.setValue(Preferences.cargo, value);
  }
}
