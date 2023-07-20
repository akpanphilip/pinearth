// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinearth/controller/main_wrapper_controller.dart';
import 'package:pinearth/screens/home_screen.dart';
import 'package:pinearth/screens/list_property_screen.dart';
import 'package:pinearth/screens/profile_screen.dart';
import 'package:pinearth/screens/saved_homes_screen.dart';
import 'package:pinearth/screens/search_screen.dart';
import 'package:pinearth/screens/updates_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class RootScreen extends StatefulWidget {
  RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final MainWrapperController controller = Get.put(MainWrapperController());

  // int _bottomNavIndex = 0;
  // list of screens
  List<Widget> pages = const [
    SearchScreen(),
    UpdatesScreen(),
    SavedHomesScreen(),
    ListPropertyScreen(),
    ProfileScreen()
  ];

  // List of screen icons
  List<IconData> iconList = [
    Icons.earbuds,
    Icons.mail_lock,
    Icons.face,
    Icons.hail,
    Icons.access_alarm,
  ];

  // List of screen title
  List<String> titleList = [
    'Search',
    'Updates',
    'Saved Homes',
    'List Property',
    'Profile',
  ];

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: IndexedStack(
  //       index: _bottomNavIndex,
  //       children: pages,
  //     ),
  //     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  //     bottomNavigationBar: AnimatedBottomNavigationBar(
  //         splashColor: Colors.red,
  //         activeColor: Colors.green,
  //         inactiveColor: Colors.green.withOpacity(.5),
  //         icons: iconList,
  //         activeIndex: _bottomNavIndex,
  //         gapLocation: GapLocation.end,
  //         notchSmoothness: NotchSmoothness.softEdge,
  //         onTap: (index) {
  //           setState(() {
  //             _bottomNavIndex = index;
  //           });
  //         }),
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: controller.animateToTab,
        controller: controller.pageController,
        physics: const BouncingScrollPhysics(),
        children: const [
          SearchScreen(),
          UpdatesScreen(),
          SavedHomesScreen(),
          ListPropertyScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bottomAppBarItem(context,
                    icon: IconlyLight.search, page: 0, label: "Search"),
                _bottomAppBarItem(context,
                    icon: IconlyLight.bookmark, page: 2, label: "Saved Homes"),
                _bottomAppBarItem(context,
                    icon: IconlyLight.notification, page: 1, label: "Updates"),
                _bottomAppBarItem(context,
                    icon: IconlyLight.category,
                    page: 3,
                    label: "List Property"),
                _bottomAppBarItem(context,
                    icon: IconlyLight.profile, page: 4, label: "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () => controller.goToTab(page),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: controller.currentPage.value == page
                  ? Color.fromARGB(255, 5, 113, 201)
                  : const Color.fromARGB(186, 158, 158, 158)),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
                fontSize: 10,
                color: controller.currentPage.value == page
                    ? Color.fromARGB(255, 5, 113, 201)
                    : Color.fromARGB(186, 158, 158, 158)),
          )
        ],
      ),
    );
  }
}
