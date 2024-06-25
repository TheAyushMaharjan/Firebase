import 'package:flutter/material.dart';
import 'package:firebase_login/models/movie.dart';
import 'package:firebase_login/screens/details_screen.dart';
import 'package:firebase_login/models/movie.dart';

class BookmarkItem {
  final String id; // Assuming id as a unique identifier for each bookmarked item
  final Movie movie;

  BookmarkItem({required this.id, required this.movie});
}
class Bookmark extends StatefulWidget {
  const Bookmark({Key? key}) : super(key: key);

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  List<BookmarkItem> bookmarks = []; // List to hold bookmarked items

  // Method to add bookmark from DetailsScreen
  void addBookmark(Movie movie) {
    setState(() {
      bookmarks.add(BookmarkItem(id: movie.id.toString(), movie: movie));
    });
  }

  // Method to remove bookmark (if needed)
  void removeBookmark(String id) {
    setState(() {
      bookmarks.removeWhere((bookmark) => bookmark.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          final bookmark = bookmarks[index];
          return ListTile(
            title: Text(bookmark.movie.title),
            subtitle: Text('ID: ${bookmark.id}'),
            onTap: () {
              // Navigate to details screen when bookmark is tapped (optional)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(movie: bookmark.movie),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
