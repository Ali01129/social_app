import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/components/my_button.dart';
import 'package:social/components/text_field.dart';
import 'package:social/helper/helper_functions.dart';

class LoginPage extends StatefulWidget {
  void Function()? onTap;
  LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    //text field controllers
    final TextEditingController emailController=TextEditingController();
    final TextEditingController pwdController=TextEditingController();

    //login
    void login()async{
      //1 show loading circle
      showDialog(context: context, builder: (context)=>const Center(child: CircularProgressIndicator(),));
      //2 Login
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: pwdController.text);
        Navigator.pop(context);
      } on FirebaseAuthException catch(e){
        Navigator.pop(context);
        displayMsgToUser(e.code, context);
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //1 logo
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
            
                const SizedBox(height: 25),
            
                //2 app name
            
                const Text(
                  "S O C I A L",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
            
                //3 email
                const SizedBox(height: 50),
                MyTextField(controller: emailController, obscureText: false, hintText: "Email"),
            
                //4 password
                const SizedBox(height: 10,),
                MyTextField(controller: pwdController, obscureText: true, hintText: "Password"),
            
                //5 forget password
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forget Password?",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                  ],
                ),
            
                //6 sign in button
                const SizedBox(height: 20,),
                MyButton(text: "Login",onTap:login),
            
                //7 register here
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(" Register Here",style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
