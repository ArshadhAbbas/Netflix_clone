import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/core/api_key.dart';
import 'package:netflix_clone/model/trending_model.dart';
import 'package:netflix_clone/presentation/search/widgets/title.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../../model/result.dart';

class SearchIdleWidget extends StatefulWidget {
  const SearchIdleWidget({super.key});

  @override
  _SearchIdleWidgetState createState() => _SearchIdleWidgetState();
}

class _SearchIdleWidgetState extends State<SearchIdleWidget> {
  bool isLoading = true;
  TrendingModel? _trendingModel;

  @override
  void initState() {
    super.initState();
    getTrendingApi();
  }

  Future<void> getTrendingApi() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/trending/all/day?api_key=$apiKey'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final trendingModel = TrendingModel.fromJson(data);
        setState(() {
          isLoading = false;
          _trendingModel = trendingModel;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'Top Searches'),
        kHeight,
        Expanded(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
                  : ListView.separated(
                      itemCount: _trendingModel?.results.length ?? 0,
                      separatorBuilder: ((context, index) => kHeight20),
                      itemBuilder: (BuildContext context, int index) =>
                          TopSearchItemTile(
                              result: _trendingModel!.results[index])),
        ),
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  const TopSearchItemTile({
    super.key,
    required this.result,
  });
  final Result result;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    String url =
        'https://image.tmdb.org/t/p/w500${result.posterPath}?api_key=$apiKey';
    return ListTile(
        leading: Container(
          width: screenWidth * 0.17,
          height: 65,
          decoration: BoxDecoration(
              image:
                  DecorationImage(fit: BoxFit.cover, image: NetworkImage(url))),
        ),
        title: Text(
          result.title ?? 'No Movie Name Found',
          style: const TextStyle(
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing:const Icon(
          CupertinoIcons.play_circle,
          color: kWhiteColor,
          size: 40,
        ));
  }
}
