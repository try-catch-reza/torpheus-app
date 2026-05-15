enum EapiRoutes {
  auth,
  associados,
  refreshToken,
  validaToken,
}

class EapiSchema {
  static const String _apiUtils = '/api/';

  String get auth => '$_apiUtils/v1/auth/login';
}
