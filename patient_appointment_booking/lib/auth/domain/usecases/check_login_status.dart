import '../repositories/auth_interface.dart';

class CheckLoginStatusUsecase {
  CheckLoginStatusUsecase(AuthInterface authInterface)
      : _authInterface = authInterface;

  final AuthInterface _authInterface;

  Future<String?> call() async {
    return await _authInterface.fetchUser();
  }
}
