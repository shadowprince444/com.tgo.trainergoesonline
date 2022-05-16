import 'package:firebase_auth/firebase_auth.dart';

abstract class ISignIn {
  Future googleSignIn() async {}
  Future firebaseAuthentication(AuthCredential authCred) async {}
}
