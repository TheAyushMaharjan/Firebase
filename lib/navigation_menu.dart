import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_login/user_panel/bookmark.dart';
import 'package:firebase_login/user_panel/homepage.dart';
import 'package:firebase_login/user_panel/search.dart';
import 'package:firebase_login/user_panel/userpanel.dart';

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
          destinations: [
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

  final List<Widget> screens = [
    Homepage(),  // Should be Stateful
    Search(),    // Should be Stateful
    Bookmark(),  // Should be Stateful
    Userpanel(), // Should be Stateful
  ];
}
