import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static GoogleSignIn googleSignIn() => _googleSignIn;
  static FirebaseAuth firebaseAuth() => _firebaseAuth;
}
