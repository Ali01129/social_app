import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social/firebase_options.dart';
import 'package:social/pages/home_page.dart';
import 'package:social/pages/profile_page.dart';
import 'package:social/pages/splash_screen.dart';
import 'package:social/pages/users_page.dart';
import 'package:social/theme/dark_mode.dart';
import 'package:social/theme/light_mode.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      // home: AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/home_page':(context)=> HomePage(),
        '/users_page':(context)=>const UsersPage(),
        '/profile_page':(context)=> ProfilePage(),
      },
    );
  }
}

