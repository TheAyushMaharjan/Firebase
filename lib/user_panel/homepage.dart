import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/admin_panel/login.dart'; // Adjust import as per your project structure

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  User? user = FirebaseAuth.instance.currentUser; // Initialize user in State

  void signOutAndNavigateToLogin() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
    } catch (e) {
      print("Sign out error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: Center(
        child: Text(user?.email ?? 'No User'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => signOutAndNavigateToLogin(), // Call signOutAndNavigateToLogin on press
        child: const Icon(Icons.logout),
      ),
    );
  }
}
