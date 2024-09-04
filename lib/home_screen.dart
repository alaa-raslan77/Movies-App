import 'package:flutter/material.dart';
import 'package:movies_app/tabs/browse_tab.dart';
import 'package:movies_app/tabs/home_tab.dart';
import 'package:movies_app/tabs/search_tab.dart';
import 'package:movies_app/tabs/settings_tab.dart';
import 'package:movies_app/tabs/watch_list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,

        currentIndex: selectedIndex,
        onTap:(index) {
          selectedIndex=index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/home.png")),
              label: "Home"),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/search.png")),
              label: "Search"),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/browse.png")),
              label: "Browse"),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/watch_list.png")),
              label: "WatchList"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined,size: 30,),
              label: "Settings"),
        ],
      ),
    );
  }

  List<Widget> tabs=[
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    WatchListTab(),
    SettingsTab()
  ];
}
