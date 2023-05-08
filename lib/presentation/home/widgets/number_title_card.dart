import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/model/trending_model.dart';

import '../../../core/api_key.dart';
import '../../../model/result.dart';
import '../../widgets/main_title.dart';
import 'number_card.dart';

class NumberTitleCard extends StatefulWidget {
  String apiUrl;
  NumberTitleCard({
    Key? key,
    required this.apiUrl,
  }) : super(key: key);

  @override
  State<NumberTitleCard> createState() => _NumberTitleCardState();
}

class _NumberTitleCardState extends State<NumberTitleCard> {
  @override
  initState() {
    super.initState();
    apiCall();
  }

  Future apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse(widget.apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      TrendingModel trendingModel = TrendingModel.fromJson(data);

      setState(() {
        imageList = trendingModel.results.map((Result result) {
          String imageUrl =
              'https://image.tmdb.org/t/p/w500${result.posterPath}?api_key=$apiKey';
          return imageUrl;
        }).toList();
      });
    }
  }

  List imageList = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitle(title: "Top 10 TV shows in India Today"),
        LimitedBox(
            maxHeight: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return NumberCard(
                    index: index + 1,
                    imageUrl: imageList[index],
                  );
                }))
      ],
    );
  }
}
