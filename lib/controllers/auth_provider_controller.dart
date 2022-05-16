import 'package:flutter/material.dart';
import 'package:machine_test_tgo/models/auth_cred.dart';
import 'package:machine_test_tgo/repository/sign_in_repo.dart';
import 'package:machine_test_tgo/utils/enums_and_constants/enums.dart';

class AuthProviderController with ChangeNotifier {
  final SignInRepo _signInRepo = SignInRepo();
  AuthCred? _authCred;
  String? errorText = "";

  String? get userId => _authCred?.userId;

  String? get token => _authCred?.token;

  setAuthCred(AuthCred authCred) {
    _authCred = authCred;
    notifyListeners();
  }

  Future<bool> googleSignIn() async {
    final googleSignInResponse = await _signInRepo.googleSignIn();
    if (googleSignInResponse.status == APiResponseStatus.completed && googleSignInResponse.data != null) {
      final firebaseResponse = await _signInRepo.firebaseAuthentication(googleSignInResponse.data!);
      if (firebaseResponse.status == APiResponseStatus.completed && firebaseResponse.data != null) {
        String tempToken = await firebaseResponse.data!.getIdToken();
        _authCred = AuthCred(
          userId: firebaseResponse.data!.uid,
          token: tempToken,
        );
        notifyListeners();
        return true;
      } else {
        errorText = firebaseResponse.message;
      }
    } else {
      errorText = googleSignInResponse.message;
    }
    notifyListeners();
    return false;
  }
}
