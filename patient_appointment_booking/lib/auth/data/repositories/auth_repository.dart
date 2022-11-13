import '../../domain/entitis/user_data.dart';
import '../../domain/repositories/auth_interface.dart';
import '../source/auth_datasource.dart';

class AuthRepository implements AuthInterface {
  AuthRepository({required AuthDataSource authDataSource})
      : _dataSource = authDataSource;
  final AuthDataSource _dataSource;
  @override
  Future<void> logout() async {
    try {
      await _dataSource.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> signIn(String email, String password) async {
    try {
      final user = await _dataSource.signIn(email, password);
      return user?.uid ?? '';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> signUp(
      String email, String password, UserData userData) async {
    try {
      final user = await _dataSource.signUp(email, password);
      await _dataSource.saveData(userData, user?.uid ?? '');
      return user?.uid ?? '';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> fetchUser() async {
    final user = await _dataSource.fetchUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }
}
