import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Search extends StatefulWidget {

  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SearchBox'
        ),
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            Container(
              width:double.infinity ,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(12),
              ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Iconsax.search_normal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey,
                filled: true,
              ),
              onChanged: (value){

              },
            ),
            ),

          ],
        ),

      ),
    );
  }
}
