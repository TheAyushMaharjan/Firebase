import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final TextEditingController emailController = TextEditingController();
  signIn() async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
