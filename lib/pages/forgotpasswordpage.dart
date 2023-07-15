import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgotpasswordpage extends StatefulWidget {
  const Forgotpasswordpage({Key? key}) : super(key: key);

  @override
  State<Forgotpasswordpage> createState() => _ForgotpasswordpageState();
}

class _ForgotpasswordpageState extends State<Forgotpasswordpage> {
  final email = TextEditingController();

  Future<void> passwordreset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Reset password link sent, check your email"),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F243A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2F243A),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Enter your email and we will send you a password reset link",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFFBEBBBB),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF444054),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: email,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  labelText: 'E-mail',
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 8, right: 6),
                    child: Icon(Icons.email_outlined, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: passwordreset,
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFDB8A74),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(15),
              shadowColor: Colors.black.withOpacity(0.4),
              elevation: 4,
            ),
            child: Text(
              "Reset password",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
