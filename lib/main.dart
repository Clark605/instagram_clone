import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/modules/home/homescreen.dart';
import 'package:instagram_clone/modules/login/login.dart';
import 'package:instagram_clone/modules/login/register.dart';
import 'package:instagram_clone/services/firebase_services.dart';
import 'package:get_it/get_it.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.instance.registerSingleton<FirebaseServices>(
    FirebaseServices(),
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'Home':(context) => const HomeScreen(),
        'Login': (context)=> LoginPage(),
        'Register':(context)=> const RegisterPage(),
      },
      initialRoute: 'Login',
      home: LoginPage(),
      theme: ThemeData(
        fontFamily: 'Instagram'
      ),
      debugShowCheckedModeBanner: false,

    );
  }


}


