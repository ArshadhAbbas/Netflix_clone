import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index, required this.imageUrl});
  final int index;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: Container(
                width: 150,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: kRadius20,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: -20,
          child: BorderedText(
            strokeWidth: 3,
            strokeColor: Colors.white,
            child: Text(
              "$index",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 140,
              ),
            ),
          ),
        )
      ],
    );
  }
}
