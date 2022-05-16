import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:machine_test_tgo/interface/i_sign_in.dart';
import 'package:machine_test_tgo/models/api_response.dart';

import '../services/firebase_auth_services.dart';

class SignInRepo implements ISignIn {
  final GoogleSignIn _googleSignIn = FirebaseAuthServices.googleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuthServices.firebaseAuth();

  @override
  Future<ApiResponse<AuthCredential>> googleSignIn() async {
    try {
      final res = await _googleSignIn.signIn();
      if (res != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await res.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        return ApiResponse<AuthCredential>.completed(credential);
      } else {
        return ApiResponse<AuthCredential>.unauthenticated("Couldn't Authenticate");
      }
    } catch (e) {
      return ApiResponse<AuthCredential>.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<User>> firebaseAuthentication(AuthCredential authCred) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(authCred);
      if (userCredential.user != null) {
        return ApiResponse<User>.completed(userCredential.user);
      } else {
        return ApiResponse<User>.unauthenticated("Couldn't Log-in");
      }
    } on FirebaseAuthException catch (e) {
      return ApiResponse<User>.error(e.code);
    } catch (e) {
      return ApiResponse<User>.error(e.toString());
    }
  }
}
