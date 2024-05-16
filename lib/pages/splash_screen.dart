import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social/auth/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const AuthPage(),));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.surface,Theme.of(context).colorScheme.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 250,),
            //1 Logo
            Icon(
              Icons.person,
              size: 150,
              color: Colors.white,
            ),
            SizedBox(height: 20,),

            //2 Name
            Text(
              "S O C I A L",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "B Y",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              "A L I   N A W A Z",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(height: 250,),
            Text(
              "chaudharyalinawazz@gmail.com",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
