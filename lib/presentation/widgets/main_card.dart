import 'package:flutter/material.dart';

import '../../core/constants.dart';

class MainCard extends StatelessWidget {
  MainCard({
    required this.imageUrl,
    super.key,
  });
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 130,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: kRadius10,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
