import 'dart:convert';

abstract class JwtDecoder {
  /// Retorna o payload completo do token como Map.
  static Map<String, dynamic> decode(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Token JWT inválido.');

    // O payload é a segunda parte — Base64Url
    final payload = parts[1];

    // Base64Url precisa de padding para funcionar com o decode padrão
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));

    return jsonDecode(decoded) as Map<String, dynamic>;
  }

  /// Retorna a lista de permissões do usuário.
  static List<String> getPermissions(String token) {
    final payload = decode(token);
    final permissions = payload['permissions'];
    if (permissions is List) {
      return List<String>.from(permissions);
    }
    return [];
  }

  /// Verifica se o token está expirado.
  static bool isExpired(String token) {
    final payload = decode(token);
    final exp = payload['exp'];
    if (exp == null) return false;
    final expDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    return DateTime.now().isAfter(expDate);
  }

  /// Verifica se o usuário tem uma permissão específica.
  static bool hasPermission(String token, String permission) {
    return getPermissions(token).contains(permission);
  }

  static String getNome(String token) {
    final payload = decode(token);
    final nome = payload['name'];
    if (nome is String) {
      return nome;
    }
    return '';
  }

  static String getRoleId(String token) {
    final payload = decode(token);
    final nome = payload['role_id'];
    if (nome is String) {
      return nome;
    }
    return '';
  }
}
