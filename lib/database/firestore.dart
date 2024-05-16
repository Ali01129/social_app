
//I will store post of users in the databse
// each post contian
// post
// email
// timestamp

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase{
  //current user
  User? user=FirebaseAuth.instance.currentUser;
  //collect of posts
  final CollectionReference posts = FirebaseFirestore.instance.collection("Posts");
  //post a message
  Future<void> addPost(String message){
    return posts.add({
      "UserEmail":user!.email,
      "PostMessage":message,
      "Timestamp":Timestamp.now(),
    });
  }
  //read posts form database
  Stream<QuerySnapshot<Map<String, dynamic>>> getPostsStream(){
    final postsStream=FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("Timestamp", descending: true)
        .snapshots();
    return postsStream;
  }
}