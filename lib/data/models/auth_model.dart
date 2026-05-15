import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String? email;
  final String? password;
  final String? slug;

  const AuthModel({
    this.email,
    this.password,
    this.slug,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
      slug: json['slug'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'slug': slug,
    };
  }

  @override
  toString() {
    return 'AuthModel('
        'email: $email, '
        'password: $password, '
        'slug: $slug'
        ')';
  }

  @override
  List<Object?> get props => [email, password, slug];
}
