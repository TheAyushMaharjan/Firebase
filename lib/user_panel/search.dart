import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../api/api.dart';
import '../models/movie.dart';
import '../screens/details_screen.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Map<String, dynamic>> searchResult = [];
  final TextEditingController searchController = TextEditingController();
  bool showList = false;
  var val1;

  void searchListFunction(String val) async {
    try {
      var results = await Api().searchMovies(val);
      setState(() {
        searchResult = results;
        showList = true;
      });
    } catch (e) {
      print('Failed to fetch data: $e');
      setState(() {
        showList = false;
      });
    }
  }

  void goToDetailScreen(String movieId) async {
    try {
      // Fetch detailed movie information using movieId
      Movie movie = await Api().getMovieDetails(movieId);

      // Navigate to detail screen and pass movie object
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(movie: movie, onBookmarkPressed: (Movie ) {  },),
        ),
      );
    } catch (e) {
      print('Failed to load movie details: $e');
      // Handle error loading details
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchBox'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                autofocus: false,
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: IconButton(
                    icon: const Icon(Iconsax.search_normal, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        val1 = searchController.text;
                        searchListFunction(val1);
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
                onSubmitted: (value) {
                  setState(() {
                    val1 = value;
                    searchListFunction(val1);
                  });
                },
                onChanged: (value) {
                  setState(() {
                    val1 = value;
                  });
                },
              ),
            ),
            if (showList && searchResult.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: searchResult.length,
                itemBuilder: (context, index) {
                  var result = searchResult[index];
                  return GestureDetector(
                    onTap: () {
                      goToDetailScreen(result['id'].toString());
                    },
                    child: Container(
                      height: 150, // Adjust height as needed
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${result['poster_path']}',
                            width: 100, // Adjust the width to make the picture bigger
                            height: double.infinity, // Use infinity to fill the height
                            fit: BoxFit.cover, // Ensure the image covers the entire area
                          ),
                        ),
                        title: Text(
                          result['title'],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Rating: ${result['vote_average']}',
                          style: const TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  );
                },
              ),


            if (showList && searchResult.isEmpty)
              const Center(child: Text('No results found')),
          ],
        ),
      ),
    );
  }
}
