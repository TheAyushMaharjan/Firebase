import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_login/admin_panel/login.dart';

class Userpanel extends StatefulWidget {
  const Userpanel({super.key});

  @override
  State<Userpanel> createState() => _UserpanelState();
}

class _UserpanelState extends State<Userpanel> {
  User? user = FirebaseAuth.instance.currentUser;

  void signOutAndNavigateToLogin() {
    // Implement your sign-out logic here
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Column(
                  children: [
                    const Icon(Icons.person, size: 40),
                    const SizedBox(height: 12,),
                    Text(
                      user?.email ?? 'No User',
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        color: Colors.grey,
                      ),
                    ),
                  ],
            ),
                  const Icon(Icons.settings, size: 40), // Settings icon
                ],
              ),
            ),
          ],
        ),
        // Your content here
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => signOutAndNavigateToLogin(),
        child: const Icon(Icons.logout),
      ),
    );
  }
}
