import 'package:carousel_slider/carousel_slider.dart';
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
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Login()));
    } catch (e) {
      print("Sign out error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome,',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      user?.email ?? 'No User',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.bookmark,
                    size: 36.0,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Handle bookmark action here
                  },
                ),
              ],
            ),
            SizedBox(height: 36),
            Text(
              'Most Watched',
              style: TextStyle(
                fontFamily: 'Clash-medium',
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: 10,
                options: CarouselOptions(
                  height: 300,
                  autoPlay: true,
                  viewportFraction: 0.55,
                  enlargeCenterPage: true,
                  pageSnapping: true,
                  autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                ),
                itemBuilder: (context, itemIndex, pageViewIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      height: 300,
                      width: 200,
                      color: Colors.greenAccent,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 36),

            Text(
              'Category',
              style: TextStyle(
                fontFamily: 'Clash-medium',
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: 8,
                options: CarouselOptions(
                  height: 50,
                  viewportFraction: 0.2,
                  pageSnapping: true,
                  enableInfiniteScroll: false,
                    initialPage: 0,
                ),
                itemBuilder: (context, itemIndex, pageViewIndex) {
                  return ClipOval(
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.greenAccent,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => signOutAndNavigateToLogin(),
      //   child: const Icon(Icons.logout),
      // ),
    );
  }
}
