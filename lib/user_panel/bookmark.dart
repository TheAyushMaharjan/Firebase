//bookmark.dart
import 'package:flutter/material.dart';
import 'package:firebase_login/models/movie.dart';
import 'package:firebase_login/screens/details_screen.dart';

class BookmarkItem {
  final String id; // Assuming id as a unique identifier for each bookmarked item
  final Movie movie;

  BookmarkItem({required this.id, required this.movie});
}

class Bookmark extends StatefulWidget {
  const Bookmark({super.key, required this.bookmarks, required this.onBookmarkPressed});

  final List<BookmarkItem> bookmarks;
  final Function(Movie) onBookmarkPressed;

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  late List<BookmarkItem> bookmarks;

  @override
  void initState() {
    super.initState();
    bookmarks = widget.bookmarks;
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
      body: bookmarks.isEmpty
          ? const Center(child: Text('No bookmarks added.'))
          : ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          final bookmark = bookmarks[index];
          return ListTile(
            title: Text(bookmark.movie.title),
            subtitle: Text('ID: ${bookmark.id}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                removeBookmark(bookmark.id);
              },
            ),
            onTap: () {
              // Navigate to details screen when bookmark is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(movie: bookmark.movie, onBookmarkPressed: (Movie ) {  },),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
