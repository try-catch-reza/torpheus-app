abstract class PreferencesLocalRepository {
  String? getAccessToken();

  String? getRefreshToken();

  Future<void> removeAccessToken();

  Future<void> removeRefreshToken();

  Future<void> saveAccessToken(String acessToken);

  Future<void> saveRefreshToken(String refreshToken);

  bool getIsUsuarioLogado();
  Future<void> saveIsUsuarioLogado(bool value);
  Future<void> removeIsUsuarioLogado();

  List<String> getListPermissions();
  Future<void> saveListPermissions(List<String> value);
  Future<void> removeListPermisions();

  String getNome();
  Future<void> saveNome(String value);
  Future<void> removeNome();

  String getEmail();
  Future<void> saveEmail(String value);
  Future<void> removeEmail();
}
