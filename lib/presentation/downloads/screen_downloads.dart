import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../../core/api_key.dart';
import '../../core/colors/colors.dart';
import '../../core/constants.dart';
import '../../model/result.dart';
import '../../model/trending_model.dart';
import '../widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});
  final _widgetList = [
    const _SmartDownloads(),
    const Section2(),
    const Section3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBarWidget(
              appbarTitle: "Downloads",
            )),
        body: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) => _widgetList[index],
            separatorBuilder: (context, index) => const SizedBox(
                  height: 25,
                ),
            itemCount: _widgetList.length));
  }
}

//section 1
class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.settings,
          color: kWhiteColor,
        ),
        kWidth,
        Text("Smart Downloads")
      ],
    );
  }
}

//section 2
class Section2 extends StatefulWidget {
  const Section2({super.key});

  @override
  State<Section2> createState() => _Section2State();
}

class _Section2State extends State<Section2> {
  List imageList = [];
  Future trendingModelApi() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/trending/all/day?api_key=$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> bodyAsJson = jsonDecode(response.body);
      TrendingModel trendingModel = TrendingModel.fromJson(bodyAsJson);
      setState(() {
        imageList = trendingModel.results.map((Result result) {
          String imageUrl =
              "https://image.tmdb.org/t/p/w500/${result.posterPath}?api_key=$apiKey";
          return imageUrl;
        }).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    trendingModelApi();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        const Text(
          "Introducing Downloads for you",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: kWhiteColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        kHeight,
        const Text(
          "We will download a personalised selection of\nmovies and shows for you, so there's\nalways something to watch on your\ndevice",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        kHeight,
        SizedBox(
          width: size.width,
          height: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: imageList.length < 3
                ? [const CircularProgressIndicator()]
                : [
                    CircleAvatar(
                      radius: size.width * 0.35,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                    ),
                    DownloadsImageWidget(
                      imageList: imageList[0],
                      margin: const EdgeInsets.only(left: 170, top: 50),
                      size: Size(size.width * 0.35, size.width * 0.55),
                      angle: 25,
                    ),
                    DownloadsImageWidget(
                      imageList: imageList[1],
                      margin: const EdgeInsets.only(right: 170, top: 50),
                      size: Size(size.width * 0.35, size.width * 0.55),
                      angle: -25,
                    ),
                    DownloadsImageWidget(
                      imageList: imageList[2],
                      radius: 10,
                      margin: const EdgeInsets.only(bottom: 35, top: 50),
                      size: Size(size.width * 0.4, size.width * 0.6),
                    ),
                  ],
          ),
        ),
      ],
    );
  }
}

//section 3

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: kButtonColorBlue,
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Set up",
                    style: TextStyle(
                        color: kWhiteColor, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ),
        kHeight,
        MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: kButtonColorWhite,
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "See what you can Download",
                style:
                    TextStyle(color: kColorBlack, fontWeight: FontWeight.bold),
              ),
            ))
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget(
      {super.key,
      required this.imageList,
      required this.margin,
      required this.size,
      this.radius = 10,
      this.angle = 0});

  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(imageList)),
              borderRadius: BorderRadius.circular(radius)),
        ),
      ),
    );
  }
}
