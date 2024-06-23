import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/admin_panel/login.dart';
import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/movie.dart';
import '../widgets/Catagory.dart';
import '../widgets/MostWatched.dart';
import '../widgets/TopRated.dart';
import '../widgets/Upcoming.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

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
    mostwatched = Api().getMostWatched();
    toprated = Api().getTopRated();
    upcoming = Api().getUpcomming();
  }

  User? user = FirebaseAuth.instance.currentUser;

  void signOutAndNavigateToLogin() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } catch (e) {
      print("Sign out error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light pink background color

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
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
            ),
            const SizedBox(height: 36),
            // Category section
            Center(
              child: const Text(
                'Category',
                style: TextStyle(
                  fontFamily: 'Clash-medium',
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Catagory(),
            const SizedBox(height: 36),

            // Consolidated section from Most Watched to Upcoming with rounded top corners
            _buildSection(
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const SizedBox(height: 24),

                    // Most Watched section
                    _buildSubSection(
                      header: const Text(
                        'Most Watched',
                        style: TextStyle(
                          fontFamily: 'Clash-medium',
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      content: FutureBuilder<List<Movie>>(
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
                    ),

                    // Top Rated Movies section
                    _buildSubSection(
                      header: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 36),
                          Text(
                            'Top Rated Movies',
                            style: TextStyle(
                              fontFamily: 'Clash-medium',
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 18),
                        ],
                      ),
                      content: FutureBuilder<List<Movie>>(
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
                    ),

                    // Upcoming section
                    _buildSubSection(
                      header: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 36),
                          Text(
                            'Upcoming',
                            style: TextStyle(
                              fontFamily: 'Clash-medium',
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 18),
                        ],
                      ),
                      content: FutureBuilder<List<Movie>>(
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),


    );
  }

  // Help to round the  top corners
  Widget _buildSection(Widget child) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        color: Colors.black12, // Section background color
        child: child,
      ),
    );
  }

  // Help to remove padding
  Widget _buildSubSection({required Widget header, required Widget content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          const SizedBox(height: 18),
          content,
        ],
      ),
    );
  }
}
