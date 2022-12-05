import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurancehero/history.dart';
import 'package:insurancehero/home.dart';
import 'package:insurancehero/ui/profile/profile.dart';
import 'package:insurancehero/utils/colors.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../controller/nav_bar_controller.dart';

class BottomNav {
  String icon;
  Color iconColor;
  Color containerColor;
  String? name;

  BottomNav({
    required this.icon,
    required this.iconColor,
    required this.containerColor,
  });

  getBottomNavItem() {
    return PersistentBottomNavBarItem(
      icon: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: SizedBox(
                  height: 22,
                  width: 22,
                  child: Image.asset(
                    "assets/images/$icon.png",
                    color: iconColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem>
      items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
  final ValueChanged<int> onItemSelected;

  CustomNavBarWidget({
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                  size: 26.0,
                  color: isSelected
                      ? (item.activeColorSecondary ?? item.activeColorPrimary)
                      : item.inactiveColorPrimary ?? item.activeColorPrimary),
              child: item.icon,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
        color: Colors.white,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  this.onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Color selectedColor = const Color(0xFF000000);
  final Color unselectedColor = const Color(0xFF707070);
  final NavBarController navBarController = Get.put(NavBarController());

  List<Widget> _buildScreens() {
    return [
      Home(),
      const HistoryView(),
      const ProfileView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      BottomNav(
        icon: "grey-home",
        iconColor: navBarController.controller.index == 0
            ? Colors.white
            : unselectedColor,
        containerColor: navBarController.controller.index == 0
            ? lightGreenColor
            : Colors.white,
      ).getBottomNavItem(),
      BottomNav(
        icon: "history",
        iconColor: navBarController.controller.index == 1
            ? Colors.white
            : unselectedColor,
        containerColor: navBarController.controller.index == 1
            ? lightGreenColor
            : Colors.white,
      ).getBottomNavItem(),
      BottomNav(
        icon: "user-small",
        containerColor: navBarController.controller.index == 2
            ? lightGreenColor
            : Colors.white,
        iconColor: navBarController.controller.index == 2
            ? Colors.white
            : unselectedColor,
      ).getBottomNavItem(),
    ];
  }

  Future<bool> showExitPopup(BuildContext? context) async {
    return await showDialog(
          context: context!,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(greenColor),
                ),
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: const Text('No'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(greenColor),
                ),
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  void initState() {
    super.initState();
           print(navBarController.currentIndex.value);
            print(navBarController.controller.index);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView.custom(
      context,
      controller: navBarController.controller,
      itemCount: _navBarsItems().length,
      // This is required in case of custom style! Pass the number of items for the nav bar.
      screens: _buildScreens(),
      navBarHeight: 90,
      onWillPop: (context) {
        return showExitPopup(context);
      },
      hideNavigationBarWhenKeyboardShows: true,
      backgroundColor: Colors.white,
      popAllScreensOnTapOfSelectedTab: true,
      confineInSafeArea: false,
      handleAndroidBackButtonPress: true,
      customWidget: (navBarEssentials) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
        ),
        child: CustomNavBarWidget(
          // Your custom widget goes here
          items: _navBarsItems(),
          selectedIndex: navBarController.currentIndex.value,
          onItemSelected: (index) {
            setState(() {
              navBarController.currentIndex.value = index;
              navBarController.controller.index =
                  index; // NOTE: THIS IS CRITICAL!! Don't miss it!
            });
            print(navBarController.currentIndex.value);
            print(navBarController.controller.index);
          },
        ),
      ),
    );
  }
}
