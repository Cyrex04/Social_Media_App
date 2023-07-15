// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/pages/forgotpasswordpage.dart';
import 'package:flutter_trial/pages/fancysignin.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback register;

  const LoginPage({Key? key, required this.register}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFAC9B8),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }

  Future<void> signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorDialog(e.code);
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F243A),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Spacer(flex: 2),
                          const Icon(
                            Icons.lock,
                            size: 130,
                            color: Color(0xFFDB8A74),
                          ),
                          const SizedBox(height: 7),
                          const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFBEBBBB),
                              fontFamily: "Poppins",
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF444054),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: TextField(
                                  controller: email,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
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
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF444054),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: TextField(
                                  controller: password,
                                  style: const TextStyle(color: Colors.white),
                                  obscureText: true,
                                  decoration: const InputDecoration(
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
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return const Forgotpasswordpage();
                                }),
                              );
                            },
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFFBEBBBB)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                            child: ElevatedButton(
                              onPressed: signIn,
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xFFDB8A74),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                padding: const EdgeInsets.all(15),
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Or continue with",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFBEBBBB),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10),
                              ImageBox(
                                imagepath: "assets/images/google.png",
                                onTap: () {
                                  GoogleSignInHelper().signInWithGoogle();
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Not registered yet?",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFFBEBBBB)),
                              ),
                              GestureDetector(
                                onTap: widget.register,
                                child: const Text(
                                  " Register now!",
                                  style: TextStyle(color: Color(0xFFDB8A74)),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ImageBox extends StatelessWidget {
  final String imagepath;
  final void Function()? onTap;

  const ImageBox({
    Key? key,
    required this.imagepath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF444054),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              imagepath,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              color: const Color(0xFFFFFFFF),
              colorBlendMode: BlendMode.modulate,
            ),
          ),
        ),
      ),
    );
  }
}
