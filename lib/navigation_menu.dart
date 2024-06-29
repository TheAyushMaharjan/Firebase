import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_login/user_panel/bookmark.dart';
import 'package:firebase_login/user_panel/homepage.dart';
import 'package:firebase_login/user_panel/search.dart';
import 'package:firebase_login/user_panel/userpanel.dart';
import 'package:firebase_login/models/movie.dart';

class NavigationMenu extends StatelessWidget {
  NavigationMenu({super.key});

  final controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 60,
          elevation: 0,
          selectedIndex: controller.selectIndex.value,
          onDestinationSelected: (index) =>
          controller.selectIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.search_normal),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.bookmark),
              label: 'Bookmark',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.menu),
              label: 'Menu',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectIndex = 0.obs;

  // Manage bookmarks as an observable list
  final RxList<BookmarkItem> bookmarks = <BookmarkItem>[].obs;

  // Method to handle bookmark toggle
  void onBookmarkPressed(Movie movie) {
    final bookmarkItem = BookmarkItem(id: movie.id.toString(), movie: movie);
    if (bookmarks.any((item) => item.id == bookmarkItem.id)) {
      bookmarks.removeWhere((item) => item.id == bookmarkItem.id);
    } else {
      bookmarks.add(bookmarkItem);
    }
  }

  // Update the screens list to use dynamic data
  List<Widget> get screens => [
    const Homepage(),  // Should be Stateful
    const Search(),    // Should be Stateful
    Obx(() => Bookmark(
      bookmarks: bookmarks.toList(),  // Pass the bookmarks as a list
      onBookmarkPressed: onBookmarkPressed,  // Pass the bookmark handler
    )),
    const Userpanel(), // Should be Stateful
  ];
}
