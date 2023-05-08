import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';
import '../../core/constants.dart';
import 'widgets/coming_soon_widget.dart';
import 'widgets/everyone_watching_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            title: const Text(
              "New & Hot",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.cast),
                color: Colors.white,
              ),
              Container(
                width: 30,
                height: 30,
                color: Colors.blue,
              ),
              kWidth
            ],
            bottom: TabBar(
                isScrollable: true,
                labelColor: kColorBlack,
                unselectedLabelColor: kWhiteColor,
                indicator:
                    BoxDecoration(borderRadius: kRadius30, color: kWhiteColor),
                tabs: const [
                  Tab(
                    text: "🍟 Coming Soon",
                  ),
                  Tab(
                    text: "👀 Everyone's Watching",
                  )
                ]),
          ),
        ),
        body: TabBarView(children: [
          _buildComingSoon(),
          _buildEveryOnesWatching(),
        ]),
      ),
    );
  }

  _buildComingSoon() {
    return ComingSoonWidget();
  }

  _buildEveryOnesWatching() {
    return const EveryonesWatchingWidget();
  }
}
