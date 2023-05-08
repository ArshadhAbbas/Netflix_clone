import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants.dart';

class AppBarWidget extends StatelessWidget {
  String appbarTitle;
  AppBarWidget({
    Key? key,
    required this.appbarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          appbarTitle,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )),
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
    );
  }
}
