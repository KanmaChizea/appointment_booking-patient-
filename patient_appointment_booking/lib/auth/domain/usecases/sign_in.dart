import '../entitis/user_entity.dart';
import '../repositories/auth_interface.dart';

class SignInUsecase {
  SignInUsecase(AuthInterface authInterface) : _authInterface = authInterface;

  final AuthInterface _authInterface;

  Future<UserEntity> call(String email, String password) async {
    return await _authInterface.signIn(email, password);
  }
}
