import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:netflix_clone/core/api_key.dart';
import 'package:netflix_clone/model/trending_model.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/video_widget.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../../model/result.dart';
import '../../home/widgets/custom_button_widget.dart';

class ComingSoonWidget extends StatefulWidget {
  const ComingSoonWidget({
    super.key,
  });

  @override
  State<ComingSoonWidget> createState() => _ComingSoonWidgetState();
}

class _ComingSoonWidgetState extends State<ComingSoonWidget> {
  List<Result> resultImage = [];

  @override
  void initState() {
    super.initState();
    trendingModelApi();
  }

  Future<void> trendingModelApi() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=en-US&page=1'));

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
        itemCount: resultImage.length,
        itemBuilder: (BuildContext context, int index) {
          String imageUrl =
              'https://image.tmdb.org/t/p/w500${resultImage[index].backdropPath}?api_key=$apiKey';

          return Padding(
            padding: const EdgeInsets.only(top: 23.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 50,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        parseDateTime(resultImage[index].releaseDate!),
                        style: const TextStyle(
                            fontSize: 18,
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VideoWidget(videoImage: imageUrl),
                      Row(
                        children: [
                          const Spacer(),
                          Row(
                            children: [
                              CustomButtonWidget(
                                icon: Icons.alarm_rounded,
                                iconLabel: 'Remind me',
                                iconSize: 16,
                                textSize: 13,
                              ),
                              kWidth,
                              CustomButtonWidget(
                                icon: Icons.info,
                                iconLabel: 'Info',
                                iconSize: 16,
                                textSize: 13,
                              ),
                              kWidth,
                            ],
                          )
                        ],
                      ),
                      kHeight,
                      Text(
                          "Coming on ${getDayName(resultImage[index].releaseDate!)}"),
                      kHeight,
                      Text(
                        resultImage[index].originalTitle ?? 'Empty Title',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1,
                        ),
                      ),
                      kHeight,
                      Text(
                        resultImage[index].overview,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      kHeight20
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  String parseDateTime(String date) {
    final formattedDate =
        DateFormat.MMMMd().format(DateTime.parse(date)).split(' ');
    return "${formattedDate.first.substring(0, 3)} \n${formattedDate.last} ";
  }

  String getDayName(String date) {
    final dayName = DateFormat('EEEE').format(DateTime.parse(date));
    return dayName;
  }
}
