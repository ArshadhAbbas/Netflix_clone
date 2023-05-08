import 'package:flutter/material.dart';
import 'package:netflix_clone/presentation/downloads/screen_downloads.dart';
import 'package:netflix_clone/presentation/fast_laugh/fast_laugh.dart';
import 'package:netflix_clone/presentation/home/screen_home.dart';
import 'package:netflix_clone/presentation/search/screen_search.dart';

import '../../core/colors/colors.dart';
import '../new_and_hot/screen_new_and_hot.dart';
import 'widgets/bottom_nav.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});
  final _pages = [
    ScreenHome(),
    ScreenNewAndHot(),
    ScreenFastLaugh(),
    ScreenSearch(),
    ScreenDownloads()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, _) {
            return _pages[index];
          },
        ),
        bottomNavigationBar: BottomNavigationWidget(),
      ),
    );
  }
}
