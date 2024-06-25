import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../api/api.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SearchBox'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                autofocus: false,
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: IconButton(
                    icon: Icon(Iconsax.search_normal, color: Colors.black),
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
                physics: NeverScrollableScrollPhysics(),
                itemCount: searchResult.length,
                itemBuilder: (context, index) {
                  var result = searchResult[index];
                  return Container(
                    height: 125,
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Image.network(
                        'https://image.tmdb.org/t/p/w500${result['poster_path']}',
                        width: 120, // Adjust the width to make the picture bigger
                        height: 125, // Adjust the height to make the picture bigger
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        result['title'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Rating: ${result['vote_average']}',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            if (showList && searchResult.isEmpty)
              Center(child: Text('No results found')),
          ],
        ),
      ),
    );
  }
}
