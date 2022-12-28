import 'package:cryptotracker/pages/MainPages/LoginPage.dart';
import 'package:cryptotracker/server/google_signin.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FloatingActionButton.extended(
        label: Text("Sign Out"),
        icon: Icon(Icons.login),
        onPressed: () async {
          bool loggedOut = await GoogleSigninHelper.signOut();

          if (loggedOut) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
                (route) => false);
          }
        },
      ),
    );
  }
}
