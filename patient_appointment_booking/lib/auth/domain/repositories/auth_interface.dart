import '../entitis/user_data.dart';

abstract class AuthInterface {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password, UserData userData);
  Future<void> logout();
  Future<String?> fetchUser();
}
