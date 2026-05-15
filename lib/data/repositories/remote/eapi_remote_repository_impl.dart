import 'package:torpheus/data/models/auth_model.dart';
import 'package:torpheus/data/models/auth_response_model.dart';

import '../../../config/eapi_schema.dart';
import '../../../core/resources/base_remote_data_source.dart';
import '../../../domain/repositories/remote/eapi_remote_repository.dart';
import '../../datasources/remote/http_client.dart';

class EapiRemoteRepositoryImpl extends BaseRemoteDataSource
    implements EapiRemoteRepository {
  EapiRemoteRepositoryImpl(super.httpClient, this._schema);

  final EapiSchema _schema;

  @override
  Future<AuthResponseModel> auth(AuthModel authModel) async {
    const titleMessage = 'Não foi possível autenticar o usuário';

    return await post(
      path: _schema.auth,
      body: authModel.toJson(),
      titleMessage: titleMessage,
      response: (response) {
        if (response.statusCode == 200) {
          return AuthResponseModel.fromJson(response.data);
        } else {
          throw HttpRequestException(
            titleMessage: titleMessage,
            infoMessage: 'Resposta inesperada do servidor.',
            response: response,
          );
        }
      },
    );
  }
}
