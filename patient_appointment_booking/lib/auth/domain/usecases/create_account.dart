import '../entitis/user_data.dart';
import '../entitis/user_entity.dart';
import '../repositories/auth_interface.dart';

class CreateAccountUsecase {
  CreateAccountUsecase(AuthInterface authInterface)
      : _authInterface = authInterface;

  final AuthInterface _authInterface;

  Future<UserEntity> call(
      String email, String password, UserData userData) async {
    return await _authInterface.signUp(email, password, userData);
  }
}
