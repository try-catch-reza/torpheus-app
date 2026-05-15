import '../../../data/models/auth_model.dart';
import '../../../data/models/auth_response_model.dart';

abstract class EapiRemoteRepository {
  // Future<RefreshToken> getNewAccessToken(String refreshToken);
  //
  // Future<void> validaToken(String accessToken);
  Future<AuthResponseModel> auth(AuthModel authModel);
}
