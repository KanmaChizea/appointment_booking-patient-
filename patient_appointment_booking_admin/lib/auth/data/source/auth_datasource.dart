import 'package:cloud_firestore/cloud_firestore.dart';

class AuthDataSource {
  final _storage = FirebaseFirestore.instance.collection('admin').doc('info');

  Future<bool> signIn(String password) async {
    final user = await _storage
        .get()
        .then((value) => value.data()!['password'] == password);
    return user;
  }
}
