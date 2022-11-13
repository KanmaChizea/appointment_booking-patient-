import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entitis/user_data.dart';

class AuthDataSource {
  final _auth = FirebaseAuth.instance;
  final _cloudStore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  Future<User?> signUp(String email, String password) async {
    final user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  Future<void> saveData(UserData userData, String id) async {
    await _cloudStore.collection('user data').doc(id).set({
      "id": userData.id,
      "firstName": userData.firstName,
      "lastName": userData.lastName,
      "department": userData.department,
      "faculty": userData.faculty
    });
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<User?> get fetchUser async {
    var firebaseUser = _auth.currentUser;
    firebaseUser ??= await _auth.authStateChanges().first;
    return firebaseUser;
  }
}
