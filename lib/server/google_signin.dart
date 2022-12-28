import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninHelper {
  static final _googleSignIn = GoogleSignIn();

  static GoogleSignInAccount? _user;

  //GoogleSignInAccount get user => _user!;

  static Future<bool> signIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return false;
    _user = googleUser;

    final googleAuth = await _user!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      print(userCredential.user!.email.toString() + " signed in!");
      //await FirebaseServise.saveDefaultUserData(userCredential);
      return true;
    } else
      return false;
  }

  static Future<bool> signOut() async {
    try {
      _googleSignIn.signOut();
      print("cikis ypaildi");
      return true;
    } catch (e) {
      print("cikis yapilamadi..");
      return false;
    }
  }
}
