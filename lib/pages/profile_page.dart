import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  //current user email
  final User? currentUser=FirebaseAuth.instance.currentUser;

  //from email getting its name
  Future<DocumentSnapshot<Map<String,dynamic>>> getUserDetails()async{
    return await FirebaseFirestore.instance
      .collection("Users")
        .doc(currentUser!.email)
        .get();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot){
          //loading
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Text("Error:${snapshot.error}");
          }
          else if(snapshot.hasData){
            Map<String,dynamic>?user=snapshot.data!.data();
            return Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                      left: 20
                    ),
                    child: Row(
                      children: [
                        MyBackButton(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.all(25),
                    child: Icon(Icons.person,size: 64,),
                  ),
                  const SizedBox(height: 25,),

                  Text(user!['username'], style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  Text(user['email'],style: TextStyle(color: Colors.grey.shade600),),
                ],
              ),
            );
          }
          else{
            return Text("No Data");
          }
        },
      ),
    );
  }
}
