import 'package:flutter/material.dart';
import '../constants.dart';

class Upcoming extends StatelessWidget {
  const Upcoming({
    super.key,
    required this.snapshot,
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add horizontal padding
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: SizedBox(
                height: 300,
                width: 150,
                child: Image.network(
                  '${Constants.imagePath}${snapshot.data[index].posterPath}', // Use `index` instead of `itemIndex`
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
