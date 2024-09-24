import 'package:check_weather/core/errors/exceptions.dart';
import 'package:check_weather/core/network/networkInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../modeles/user_model.dart';

abstract class RemoteDataScorce {
  Future<void> logout();
  Future<void> ressetPassword(String email);
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(
      String email, String phone, String name, String password);
}

class RemotedatascorceImpl implements RemoteDataScorce {
  final Networkinfo networkinfo;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  RemotedatascorceImpl(
      {required this.networkinfo,
      required this.firebaseAuth,
      required this.firestore});

  @override
  Future<UserModel> login(String email, String password) async {
    bool isconnected = await networkinfo.isConnected;
    if (isconnected) {
      try {
        final userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        final user = userCredential.user;

        if (user != null) {
          final userDoc =
              await firestore.collection('users').doc(user.uid).get();
          return UserModel.fromjson(userDoc.data()!);
        } else {
          throw WrongDataException();
        }
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<void> logout() async {
    bool isconnected = await networkinfo.isConnected;
    if (isconnected) {
      try {
        await firebaseAuth.signOut();
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<void> ressetPassword(String email) async {
    bool isconnected = await networkinfo.isConnected;
    if (isconnected) {
      try {
        await firebaseAuth.sendPasswordResetEmail(email: email);
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<UserModel> signup(
      String email, String phone, String name, String password) async {
    bool isconnected = await networkinfo.isConnected;
    if (isconnected) {
      try {
        final userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        final user = userCredential.user;
        if (user != null) {
          final usermodel =
              UserModel(id: user.uid, name: name, email: email, phone: phone);
          await firestore
              .collection('users')
              .doc(user.uid)
              .set(usermodel.tojson());
          return usermodel;
        } else {
          throw WrongDataException();
        }
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }
}
