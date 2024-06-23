import 'package:flutter/material.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks', style: Theme.of(context).textTheme.headlineMedium,),
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
