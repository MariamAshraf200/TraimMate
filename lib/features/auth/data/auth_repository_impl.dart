import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../domain/auth_repository.dart';
import '../domain/entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(this.firebaseAuth);

  @override
  Future<User?> login(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return User(uid: credential.user!.uid, email: credential.user!.email!);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User?> signUp(String email, String password, String name, String phone) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user!.updateDisplayName(name);


      return User(
        uid: credential.user!.uid,
        email: credential.user!.email!,
        name: name,
        phone: phone,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<User?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return User(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        name: firebaseUser.displayName ?? '',
      );
    } else {
      return null;
    }
  }
}
