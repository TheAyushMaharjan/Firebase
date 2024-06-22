import 'package:firebase_login/api/api.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/admin_panel/login.dart';
import '../models/movie.dart';
import '../widgets/Catagory.dart';
import '../widgets/MostWatched.dart';
import '../widgets/TopRated.dart';
import '../widgets/Upcoming.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<Movie>> mostwatched;
  late Future<List<Movie>> toprated;
  late Future<List<Movie>> upcoming;

  @override
  void initState() {
    super.initState();
    mostwatched = Api().getMostWatched(); //
    toprated = Api().getTopRated();
    upcoming = Api().getUpcomming();
  }

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
                    const Text(
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
                      style: const TextStyle(
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
            const SizedBox(height: 36),
            const Text(
              'Most Watched',
              style: TextStyle(
                fontFamily: 'Clash-medium',
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 36),
            FutureBuilder<List<Movie>>(
              future: mostwatched,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  return MostWatched(snapshot: snapshot);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 36),
            const Text(
              'Category',
              style: TextStyle(
                fontFamily: 'Clash-medium',
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 36),
            const Catagory(),
            const SizedBox(height: 36),
            const Text(
              'Top Rated Movies',
              style: TextStyle(
                fontFamily: 'Clash-medium',
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 18),
            FutureBuilder<List<Movie>>(
              future: toprated,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  return TopRated(snapshot: snapshot);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 36),
            const Text(
              'Upcomming',
              style: TextStyle(
                fontFamily: 'Clash-medium',
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 18),
            FutureBuilder<List<Movie>>(
              future: upcoming,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  return Upcoming(snapshot: snapshot);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => signOutAndNavigateToLogin(),
        child: const Icon(Icons.logout),
      ),

    );
  }
}
