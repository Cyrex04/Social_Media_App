import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/components/comment.dart';
import 'package:flutter_trial/components/like_button.dart';

class WallPost extends StatefulWidget {
  final String massage;
  final String user;
  final String postId;
  final List<String> likes;

  WallPost({
    Key? key,
    required this.user,
    required this.massage,
    required this.likes,
    required this.postId,
  }) : super(key: key);

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  int commentCount = 0;
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = true;
  final commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
    _fetchCommentCount();
  }

  void _fetchCommentCount() {
    FirebaseFirestore.instance
        .collection("Userposts")
        .doc(widget.postId)
        .collection("comments")
        .snapshots()
        .listen((snapshot) {
      setState(() {
        commentCount = snapshot.docs.length;
      });
    });
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      DocumentReference getRef =
          FirebaseFirestore.instance.collection("Userposts").doc(widget.postId);
      if (isLiked) {
        getRef.update({
          'likes': FieldValue.arrayUnion([currentUser.email]),
        });
      } else {
        getRef.update({
          'likes': FieldValue.arrayRemove([currentUser.email]),
        });
      }
    });
  }

  void addComment(String comment) {
    FirebaseFirestore.instance
        .collection("Userposts")
        .doc(widget.postId)
        .collection("comments")
        .add({
      "massage": comment,
      "sender": currentUser.email,
      "time": Timestamp.now()
    });
  }

  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add a comment"),
        content: TextField(controller: commentController),
        actions: [
          TextButton(
            onPressed: () {
              commentController.clear();
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              addComment(commentController.text);
              commentController.clear();
              Navigator.pop(context);
            },
            child: const Text("Post"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF444054),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF444054).withOpacity(0.4),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.massage,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      likebutton(
                        isliked: isLiked,
                        onlike: toggleLike,
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.likes.length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: showCommentDialog,
                        child: Icon(
                          Icons.comment,
                          color: Color(0xFFDB8A74),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        commentCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Userposts")
                .doc(widget.postId)
                .collection("comments")
                .orderBy("time", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((docs) {
                    final commentData = docs.data() as Map<String, dynamic>;
                    return Comment(
                      commentText: commentData["massage"],
                      commentSender: commentData["sender"],
                    );
                  }).toList(),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
