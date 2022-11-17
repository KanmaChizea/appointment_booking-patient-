import '../interface/auth_interface.dart';

class SignInUseCase {
  SignInUseCase(AuthInterface authInterface) : _authInterface = authInterface;
  final AuthInterface _authInterface;

  Future<bool> call(String password) async {
    return await _authInterface.signIn(password);
  }
}
