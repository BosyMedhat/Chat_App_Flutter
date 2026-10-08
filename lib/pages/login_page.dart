import 'dart:js';

import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/signup_page.dart';
import 'package:scholar_chat/widgets/Custom_Text_Field.dart';

import '../widgets/Custom_Button.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<LogInPage> {
  bool isLoading = false;
  String? email;
  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                ),
                Image.asset(kLogo),
                Text(
                  "Scholar Chat",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Pacifico",
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "LogIn",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                CustomTextField(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: "Email"),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: "Password",
                  obscureText: true,
                ),
                SizedBox(
                  height: 40,
                ),
                // Line 52
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await signIn();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ChatPage(
                              email: email!,
                            );
                          }),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "email not found") {
                          showSnackBar(context, "email not found");
                        } else if (e.code == "wrong password") {
                          showSnackBar(context, "wrong password");
                        }

                        showSnackBar(context, "error");
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  btnName: "Login",
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have Account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpPage();
                            }, // Replace with your target page widget
                          ),
                        );
                      },
                      child: Text(
                        " SignUp",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> signIn() async {
    var auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
