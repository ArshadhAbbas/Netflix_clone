import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/core/api_key.dart';
import 'package:netflix_clone/model/trending_model.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/video_widget.dart';

import '../../../core/constants.dart';
import '../../../model/result.dart';
import '../../home/widgets/custom_button_widget.dart';

class EveryonesWatchingWidget extends StatefulWidget {
  const EveryonesWatchingWidget({
    super.key,
  });

  @override
  State<EveryonesWatchingWidget> createState() =>
      _EveryonesWatchingWidgetState();
}

class _EveryonesWatchingWidgetState extends State<EveryonesWatchingWidget> {
  List<Result> resultImage = [];

  @override
  void initState() {
    super.initState();
    trendingModelApi();
  }

  Future<void> trendingModelApi() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=1'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        TrendingModel trendingModel = TrendingModel.fromJson(data);

        setState(() {
          resultImage = trendingModel.results;
        });
      } else {
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: resultImage.length,
        itemBuilder: (BuildContext context, int index) {
          String imageUrl =
              'https://image.tmdb.org/t/p/w500${resultImage[index].backdropPath}?api_key=$apiKey';
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VideoWidget(
                  videoImage: imageUrl,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButtonWidget(
                        icon: Icons.share,
                        iconLabel: 'Share',
                        iconSize: 20,
                        textSize: 16,
                      ),
                      kWidth,
                      CustomButtonWidget(
                        icon: Icons.add,
                        iconLabel: 'My List',
                        iconSize: 20,
                        textSize: 16,
                      ),
                      kWidth,
                      CustomButtonWidget(
                        icon: Icons.play_arrow,
                        iconLabel: "Play",
                        iconSize: 20,
                        textSize: 16,
                      ),
                      kWidth,
                    ],
                  ),
                ),
                kHeight,
                Text(
                  resultImage[index].originalTitle ?? 'No Title Found',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kHeight,
                Text(
                  resultImage[index].overview,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        });
  }
}
