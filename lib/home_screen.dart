import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/cubit_setstate.dart';
import 'package:movies_app/bloc/state_setstate.dart';
import 'package:movies_app/tabs/browse_tab.dart';
import 'package:movies_app/tabs/home_tab.dart';
import 'package:movies_app/tabs/search_tab.dart';
import 'package:movies_app/tabs/settings_tab.dart';
import 'package:movies_app/tabs/watch_list_tab.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "home";

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetStateCubit(),
      child: BlocConsumer<SetStateCubit, SetState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: tabs[SetStateCubit.get(context).selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              iconSize: 35,
              currentIndex: SetStateCubit.get(context).selectedIndex,
              onTap: (index) {
                SetStateCubit.get(context).ChangeBottmBar(index);
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
                    icon: Icon(
                      Icons.settings_outlined,
                      size: 30,
                    ),
                    label: "Settings"),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    WatchListTab(),
    SettingsTab()
  ];
}
