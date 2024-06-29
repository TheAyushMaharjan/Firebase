import 'package:firebase_login/models/movie.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../screens/details_screen.dart';

class TopRated extends StatelessWidget {
  const TopRated({
    super.key,
    required this.snapshot, required void Function(Movie movie) onBookmarkPressed,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data?.length ?? 0, // Safeguard against null data
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    movie: snapshot.data[index], onBookmarkPressed: (Movie ) {  },
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  height: 300,
                  width: 150,
                  child: Image.network(
                    '${Constants.imagePath}${snapshot.data[index].posterPath}',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover, // Use BoxFit.contain to fit the entire image within the box
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
