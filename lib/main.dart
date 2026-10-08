import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scholar_chat/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBAPxeW0i8ZUfjLz88DvQZS3MMqOjx5Xag",
      authDomain: "chat-app-bc0f4.firebaseapp.com",
      projectId: "chat-app-bc0f4",
      storageBucket: "chat-app-bc0f4.firebasestorage.app",
      messagingSenderId: "332141727634",
      appId: "1:332141727634:web:d233680f55eacc9de2bb4b",
    ),
  );

  runApp(const ScholarChat());
}

// 2. Widget class
class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInPage(),
    );
  }
}
