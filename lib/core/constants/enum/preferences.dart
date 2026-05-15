enum Preferences {
  accessToken('acess_token'),
  refreshToken('refresh_token'),
  isUsuarioLogado('is_usuario_logado'),
  permissions('permissions'),
  email('email'),
  nome('email');

  final String key;

  const Preferences(this.key);
}
