import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/model/trending_model.dart';

import '../../../core/api_key.dart';
import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../../model/result.dart';
import 'custom_button_widget.dart';

class BackgroundCard extends StatefulWidget {
  const BackgroundCard({super.key});

  @override
  State<BackgroundCard> createState() => _BackgroundCardState();
}

class _BackgroundCardState extends State<BackgroundCard> {
  Future trendingModelApi() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/trending/all/day?api_key=$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      TrendingModel trendingModel = TrendingModel.fromJson(data);
      setState(() {
        if (trendingModel.results.isNotEmpty) {
          Result result = trendingModel.results[1];
          imageUrl =
              "https://image.tmdb.org/t/p/w500/${result.posterPath}?api_key=$apiKey";
        }
      });
    }
  }

  String? imageUrl;
  @override
  void initState() {
    super.initState();
    trendingModelApi();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 650,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
              imageUrl ?? kMainImage,
            )),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtonWidget(icon: Icons.add, iconLabel: "My List"),
                _playButton(),
                CustomButtonWidget(icon: Icons.info_outline, iconLabel: "Info")
              ],
            ),
          ),
        )
      ],
    );
  }
}

TextButton _playButton() {
  return TextButton.icon(
    onPressed: () {},
    icon: const Icon(
      Icons.play_arrow,
      size: 25,
      color: kColorBlack,
    ),
    label: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        "Play",
        style: TextStyle(fontSize: 20, color: kColorBlack),
      ),
    ),
    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kWhiteColor)),
  );
}
