import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_1/firebase_options.dart';
import 'package:project_1/pages/SignIn.dart';
import 'package:project_1/pages/SignUp.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp(),
    );
  }
}

