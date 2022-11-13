import '../entitis/user_data.dart';
import '../repositories/auth_interface.dart';

class CreateAccountUsecase {
  CreateAccountUsecase(AuthInterface authInterface)
      : _authInterface = authInterface;

  final AuthInterface _authInterface;

  Future<String> call(String email, String password, UserData userData) async {
    return await _authInterface.signUp(email, password, userData);
  }
}
