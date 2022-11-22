import '../source/auth_datasource.dart';
import '../../domain/interface/auth_interface.dart';

class AuthRepository implements AuthInterface {
  AuthRepository(AuthDataSource dataSource) : _dataSource = dataSource;

  final AuthDataSource _dataSource;

  @override
  Future<bool> signIn(String password) async {
    try {
      final value = await _dataSource.signIn(password);
      return value;
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
