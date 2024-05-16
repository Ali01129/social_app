import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social/components/my_back_button.dart';
import 'package:social/components/my_list_tile.dart';
import 'package:social/helper/helper_functions.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context,snapshot){
          //error
          if(snapshot.hasError){
            displayMsgToUser("Something went wrong", context);
          }
          //show loading bar
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          //if there is no data
          if(snapshot.data==null){
            return const Text("No Data");
          }
          final users = snapshot.data!.docs;
          return Column(
            children: [
              //back button
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

              //List of users
              const SizedBox(height: 25,),
              Expanded(
                  child:ListView.builder(
                      itemCount: users.length,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context,index){
                        final user=users[index];
                        final username=user['username'];
                        final email=user['email'];
                        return MyListTile(title: username, subtitle: email);
                      }
                      ),
              ),
            ],
          ) ;
        },
      ),
    );
  }
}
