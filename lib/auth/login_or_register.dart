import 'package:flutter/material.dart';
import 'package:social/pages/login_page.dart';
import 'package:social/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //toggle
  bool showLoginPage=true;

  void togglePage(){
    setState(() {
      showLoginPage=!showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(onTap: togglePage,);
    }
    else{
      return RegisterPage(onTap: togglePage,);
    }
  }
}
