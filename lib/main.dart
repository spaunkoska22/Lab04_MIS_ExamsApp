import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'screens/register_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyApOndS8cfC3lXzktnWRfm6UbXNDhF7Eis",
      appId: "1:147647554217:android:0c85e100ef2221d9317fb8",
      messagingSenderId: "147647554217",
      projectId: "examsapp-191010",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Exams App',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: LogInScreen.idScreen,
        routes: {
          MainScreen.idScreen: (context) => MainScreen(),
          LogInScreen.idScreen: (context) => LogInScreen(),
          RegisterScreen.idScreen: (context) => RegisterScreen(),
        });
  }
}

//191010