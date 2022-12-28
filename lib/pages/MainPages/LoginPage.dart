import 'package:cryptotracker/pages/MainPages/HomePage.dart';
import 'package:cryptotracker/providers/market_provider.dart';
import 'package:cryptotracker/server/firebase_service.dart';
import 'package:cryptotracker/server/google_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViState createState() => _LoginViState();
}

class _LoginViState extends State<LoginView> {
  User? user = FirebaseAuth.instance.currentUser;
  MarketProvider marketProvider = MarketProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lutfen Giriş Yapınız"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "lib/img/bg.jpeg",
          ),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: FloatingActionButton.extended(
            label: Text("Google Login"),
            icon: Icon(Icons.login),
            onPressed: () async {
              bool loggedIn = await GoogleSigninHelper.signIn();
              User? currentUser = FirebaseAuth.instance.currentUser;
              if (loggedIn) {
                FirebaseService.addNewUser(currentUser!);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false);
              }
            },
          ),
        ),
      ),
    );
  }
}
