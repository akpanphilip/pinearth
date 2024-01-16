// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/home_screen.dart';
import 'package:pinearth/screens/list_property/list_property_screen.dart';
import 'package:pinearth/screens/profile/profile_screen.dart';
import 'package:pinearth/screens/saved_homes_screen.dart';
import 'package:pinearth/screens/updates_screen.dart';
import 'package:pinearth/screens/widgets/side_bar_widget.dart';
import 'package:pinearth/utils/styles/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class RootScreen extends ConsumerStatefulWidget {
  RootScreen({super.key});

  @override
  ConsumerState<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen> {

  // int _bottomNavIndex = 0;
  // list of screens
  List<Widget> pages = const [
    HomeScreen(),
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

  int _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileP = ref.watch(profileProvider);
    final profile = profileP.profileState;
    // bool hasRole = false;
    bool canList = false;
    if (profile.data != null) {
      // hasRole = profile.data!.hasRole!;
      canList = profileP.canList;
    }
    print("user can list $canList");
    return Scaffold(
      body: pages[_bottomNavIndex],
      drawer: Drawer(
        backgroundColor: appColor.primary,
        child: SideBarWidget(),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bottomAppBarItem(context,
                  icon: IconlyLight.home, page: 0, label: "Home"),
              _bottomAppBarItem(context,
                  icon: IconlyLight.bookmark, page: 2, label: "Saved Homes"),
              _bottomAppBarItem(context,
                  icon: IconlyLight.notification, page: 1, label: "Updates"),
              if (canList)
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
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () => setState(() {
        _bottomNavIndex = page;
      }),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: _bottomNavIndex == page
                  ? Color.fromARGB(255, 5, 113, 201)
                  : const Color.fromARGB(186, 158, 158, 158)),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
                fontSize: 10,
                color: _bottomNavIndex == page
                    ? Color.fromARGB(255, 5, 113, 201)
                    : Color.fromARGB(186, 158, 158, 158)),
          )
        ],
      ),
    );
  }
}
