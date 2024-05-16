import 'package:flutter/material.dart';

class MyPostButton extends StatelessWidget {
  void Function()? onTap;
  MyPostButton({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.done,color: Theme.of(context).colorScheme.inversePrimary,),
      ),
    );
  }
}
