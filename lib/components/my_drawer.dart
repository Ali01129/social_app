import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    void logout(){
      FirebaseAuth.instance.signOut();
    }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(child: Icon(Icons.person,size: 80,color: Theme.of(context).colorScheme.inversePrimary,)),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("H O M E",style: TextStyle(fontSize: 15),),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("P R O F I L E",style: TextStyle(fontSize: 15),),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text("U S E R S",style: TextStyle(fontSize: 15),),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,bottom: 25),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("L O G O U T",style: TextStyle(fontSize: 15),),
              onTap: (){
                logout();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
