import 'package:equatable/equatable.dart';

class AuthResponseModel extends Equatable {
  final String? acessToken;
  final String? tokenType;
  final int? expiresIn;

  const AuthResponseModel({
    required this.acessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      acessToken: json['accessToken'] as String?,
      tokenType: json['tokenType'] as String?,
      expiresIn: json['expiresIn'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': acessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
    };
  }

  @override
  toString() {
    return 'AuthResponseModel('
        'acessToken: $acessToken, '
        'tokenType: $tokenType, '
        'expiresIn: $expiresIn'
        ')';
  }

  @override
  List<Object?> get props => [acessToken, tokenType, expiresIn];
}