import '../repositories/auth_interface.dart';

class SignOutUsecase {
  SignOutUsecase(AuthInterface authInterface) : _authInterface = authInterface;

  final AuthInterface _authInterface;

  Future<void> call() async {
    return await _authInterface.logout();
  }
}
