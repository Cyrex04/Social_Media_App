import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class likebutton extends StatelessWidget {
  final bool isliked;
  void Function()? onlike;
  likebutton({super.key, required this.isliked, required this.onlike});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onlike,
      child: Icon(
        isliked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
        color: isliked ? Color(0xFFDB8A74) : Colors.grey,
      ),
    );
  }
}
