import 'package:flutter/material.dart';
import 'package:flutter_trial/pages/fancysignin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showlogin;

  const RegisterPage({Key? key, required this.showlogin}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final confirmedPassword = TextEditingController();
  bool isRegistering = false;

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFAC9B8),
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }

  Future<void> signup() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    if (_password.text.trim() == confirmedPassword.text.trim()) {
      setState(() {
        isRegistering = true;
      });

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showErrorMessage(e.code);
      }

      setState(() {
        isRegistering = false;
      });
    } else {
      showErrorMessage("The passwords do not match");
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    confirmedPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF2F243A),
        body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Sign up!',
                style: GoogleFonts.poppins(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFBEBBBB),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF444054),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextField(
                          controller: _email,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF444054),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextField(
                          controller: _password,
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(
                              Icons.password_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF444054),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextField(
                          controller: confirmedPassword,
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Confirm your password',
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(
                              Icons.password_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: GestureDetector(
                        onTap: signup,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFDB8A74),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: isRegistering
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Or continue with",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFBEBBBB),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageBox(
                            imagepath: "assets/images/google.png",
                            onTap: () {
                              GoogleSignInHelper().signInWithGoogle();
                              bool googleSignedIn = true;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFBEBBBB)),
                        ),
                        GestureDetector(
                          onTap: widget.showlogin,
                          child: Text(
                            " Login!",
                            style: TextStyle(color: Color(0xFFDB8A74)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          )),
        ));
  }
}
