import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_clone/model/trending_model.dart';
import 'package:netflix_clone/presentation/search/widgets/title.dart';
import 'package:http/http.dart' as http;

import '../../../core/api_key.dart';
import '../../../model/result.dart';

class SearchResultWidget extends StatefulWidget {
  const SearchResultWidget({Key? key, required this.searchQuery})
      : super(key: key);

  final String searchQuery;

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  bool _isLoading = true;
  List<String> imageList = [];

  @override
  void initState() {
    super.initState();
    loadSearchResults();
  }

  Future loadSearchResults() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=${widget.searchQuery}'));
      if (response.statusCode == 200) {
        Map<String, dynamic> bodyAsJson =
            jsonDecode(response.body) as Map<String, dynamic>;
        TrendingModel trendingModel = TrendingModel.fromJson(bodyAsJson);
        setState(() {
          imageList = trendingModel.results.map((Result result) {
            String imageUrl =
                "https://image.tmdb.org/t/p/w500/${result.posterPath}?api_key=$apiKey";
            return imageUrl;
          }).toList();
        });
      } else {
        print('Failed to load search results: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to load search results: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (imageList.isEmpty) {
      return const ListTile(title: Text('No Movies Found'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'Movies & TV'),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 1 / 1.4,
            children: imageList
                .map((imageUrl) => MainCard(imageUrl: imageUrl))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  final String imageUrl;
  const MainCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 150,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}
