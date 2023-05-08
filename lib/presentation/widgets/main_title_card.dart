import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_clone/model/trending_model.dart';
import 'package:netflix_clone/presentation/widgets/main_card.dart';
import 'package:http/http.dart' as http;

import '../../core/api_key.dart';
import '../../model/result.dart';
import 'main_title.dart';

class MainTitleCard extends StatefulWidget {
  final String title;
  final String apiUrl;
  const MainTitleCard({
    super.key,
    required this.title,
    required this.apiUrl,
  });

  @override
  State<MainTitleCard> createState() => _MainTitleCardState();
}

class _MainTitleCardState extends State<MainTitleCard> {
  Future trendingModelApi() async {
    final response = await http.get(Uri.parse(widget.apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      TrendingModel trendingMoviesModel = TrendingModel.fromJson(data);

      setState(() {
        imageList = trendingMoviesModel.results.map((Result result) {
          String imageUrl =
              'https://image.tmdb.org/t/p/w500${result.posterPath}?api_key=$apiKey';
          return imageUrl;
        }).toList();
      });
    }
  }

  List imageList = [];
  @override
  initState() {
    super.initState();
    trendingModelApi();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: widget.title),
        LimitedBox(
            maxHeight: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return MainCard(imageUrl: imageList[index]);
              },
            ))
      ],
    );
  }
}
