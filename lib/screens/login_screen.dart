import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/main_screen.dart';
import '../screens/register_screen.dart';

class LogInScreen extends StatefulWidget {
  static const String idScreen = "loginScreen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loginFail = false;
  bool passwordError = false;
  bool emailError = false;
  String loginErrorMessage = "";

  Future _signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text)
          .then((value) {
        print("User signed in");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      });
    } on FirebaseAuthException catch (e) {
      print("ERROR HERE");
      print(e.message);
      loginFail = true;
      loginErrorMessage = e.message!;

      if (loginErrorMessage ==
          "There is no user record corresponding to this identifier. The user may have been deleted.") {
        emailError = true;
        loginErrorMessage = "User does not exist, please create an account";
      } else {
        passwordError = true;
        loginErrorMessage = "Incorrect password";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                child: Column(children: <Widget>[
                  SizedBox(height: 40),
                  Text(
                    "Добредојдовте",
                    style: TextStyle(
                        color: Colors.pink[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                  SizedBox(height: 60),
                  TextField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Email",
                        errorText: emailError ? loginErrorMessage : null),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelText: "Password",
                        errorText: passwordError ? loginErrorMessage : null),
                    obscureText: true,
                  ),
                  SizedBox(height: 60),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    icon: Icon(
                      Icons.login,
                      size: 32,
                    ),
                    label: Text(
                      "Логирај се",
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: _signIn,
                  ),
                  SizedBox(height: 20),
                  signUpOption()
                ]))));
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Немаш профил?"),
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
            },
            child: const Text(
              " Пријави се",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
