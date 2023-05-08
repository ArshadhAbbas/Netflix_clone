import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (context, int newIndex, child) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: backgroundColor,
          currentIndex: newIndex,
          onTap: (index) {
            indexChangeNotifier.value = index;
          },
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_collection_rounded), label: "New & Hot"),
            BottomNavigationBarItem(
                icon: Icon(Icons.emoji_emotions), label: "Fast Laughs"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_down_outlined),
                label: "Downloads")
          ],
        );
      },
    );
  }
}
