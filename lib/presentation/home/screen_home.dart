import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_clone/core/api_key.dart';

import 'package:netflix_clone/core/constants.dart';

import '../widgets/main_title_card.dart' show MainTitleCard;
import 'widgets/background_card.dart';
import 'widgets/number_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: scrollNotifier,
            builder: (context, value, _) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;
                  if (direction == ScrollDirection.reverse) {
                    scrollNotifier.value = false;
                  } else if (direction == ScrollDirection.forward) {
                    scrollNotifier.value = true;
                  }
                  return true;
                },
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        const BackgroundCard(),
                        const MainTitleCard(
                            title: "Upcoming",
                            apiUrl:
                                "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=en-US&page=1"),
                        kHeight,
                        const MainTitleCard(
                            title: "Trending Now",
                            apiUrl:
                                "https://api.themoviedb.org/3/trending/all/day?api_key=$apiKey"),
                        kHeight,
                        NumberTitleCard(
                            apiUrl:
                                "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=en-US&page=1"),
                        kHeight,
                        const MainTitleCard(
                            title: "Top Rated",
                            apiUrl:
                                'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=en-US&page=1'),
                        kHeight,
                        const MainTitleCard(
                          title: "Popular",
                          apiUrl:
                              "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=1",
                        )
                      ],
                    ),
                    scrollNotifier.value
                        ? AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            width: double.infinity,
                            height: 90,
                            color: Colors.black.withOpacity(0.2),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      "https://loodibee.com/wp-content/uploads/Netflix-N-Symbol-logo.png",
                                      height: 50,
                                      width: 50,
                                    ),
                                    const Spacer(),
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
                                  ],
                                ),
                                kHeight,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text("TV Shows", style: kHomeTitleText),
                                    Text("Movies", style: kHomeTitleText),
                                    Text("Categories", style: kHomeTitleText)
                                  ],
                                )
                              ],
                            ),
                          )
                        : kHeight
                  ],
                ),
              );
            }));
  }
}
