import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String idScreen = "registerScreen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future _signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text)
          .then((value) {
        print("Created new account");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      });
    } on FirebaseAuthException catch (e) {
      print("ERROR HERE");
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Пријави се",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                child: Column(children: <Widget>[
                  SizedBox(height: 60),
                  TextField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Enter your email"),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    decoration:
                    InputDecoration(labelText: "Enter your password"),
                    obscureText: true,
                  ),
                  SizedBox(height: 60),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    icon: Icon(
                      Icons.lock_open,
                      size: 32,
                    ),
                    label: Text(
                      "Креирај профил",
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: _signUp,
                  ),
                ])
            )
        )
    );
  }
}
