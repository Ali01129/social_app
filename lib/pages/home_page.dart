import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/components/my_drawer.dart';
import 'package:social/components/my_list_tile.dart';
import 'package:social/components/my_post_button.dart';
import 'package:social/components/text_field.dart';
import 'package:social/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //database access
  final FirestoreDatabase database=FirestoreDatabase();
  //text controller
  final TextEditingController newPost=TextEditingController();
  //post message
  void PostMessage(){
    //only post message if there is something in textfield
     if(newPost.text.isNotEmpty){
       String message=newPost.text;
       database.addPost(message);
     }
     newPost.clear();
  }
  @override
  Widget build(BuildContext context) {
    //logout

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(child: MyTextField(controller: newPost, obscureText: false, hintText: "Say Something..."),),
                MyPostButton(onTap: PostMessage),
              ],
            ),
          ),
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context,snapshot){
              //show loading circle
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              //get all post
              final posts=snapshot.data!.docs;
              //no data
              if(snapshot.data==null || posts.isEmpty){
                return const Center(
                  child: Padding(
                      padding: EdgeInsets.all(20),
                    child: Text("No Posts.. Post something!"),
                  ),
                );
              }
              //return as list
              return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                      itemBuilder: (context,index){
                        final post=posts[index];
                        String message=post['PostMessage'];
                        String email=post['UserEmail'];
                        Timestamp timestamp=post['Timestamp'];
                        return MyListTile(title: message, subtitle: email);
                      }
                  ),
              );
            },
          )
        ],
      ),
    );
  }
}

