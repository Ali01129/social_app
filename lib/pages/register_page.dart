import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/components/my_button.dart';
import 'package:social/components/text_field.dart';
import 'package:social/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  void Function()? onTap;
  RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text field controllers
  final TextEditingController usernameController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController pwdController=TextEditingController();
  final TextEditingController cpwdController=TextEditingController();
  //register
  void register()async{

    //1 show loading circle
    showDialog(
        context: context,
        builder: (context)=>const Center(
          child: CircularProgressIndicator(),
        )
    );
    //2 check password match
    if(pwdController.text!=cpwdController.text){
      //pop loading circle
      Navigator.pop(context);
      //show error msg
      displayMsgToUser("Passwords don't Match!",context);
    }
    else{
      //3 create user
      try{
        UserCredential? userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: pwdController.text);

        createUserDocument(userCredential);

        Navigator.pop(context);
      } on FirebaseAuthException catch(e){
        Navigator.pop(context);
        displayMsgToUser(e.code, context);
      }
    }
  }
  Future<void> createUserDocument(UserCredential?userCredential)async{
    if(userCredential !=null && userCredential.user!=null){
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        "email":userCredential.user!.email,
        "username":usernameController.text,
      });
    }
  }
  @override
  Widget build(BuildContext context) {
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
                MyTextField(controller: usernameController, obscureText: false, hintText: "UserName"),
            
                const SizedBox(height: 10,),
                MyTextField(controller: emailController, obscureText: false, hintText: "Email"),
            
                //4 password
                const SizedBox(height: 10,),
                MyTextField(controller: pwdController, obscureText: true, hintText: "Password"),
            
                const SizedBox(height: 10,),
                MyTextField(controller: cpwdController, obscureText: true, hintText: "Confirm Password"),
            
                //6 sign in button
                const SizedBox(height: 20,),
                MyButton(text: "Register",onTap:register),
            
                //7 register here
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(" Login Here",style: TextStyle(fontWeight: FontWeight.bold),),
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
