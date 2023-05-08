import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  IconData icon;
  String iconLabel;
  final double textSize;
  final double iconSize;

  CustomButtonWidget(
      {Key? key,
      required this.icon,
      required this.iconLabel,
      this.iconSize = 30,
      this.textSize = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: kWhiteColor,
          size: iconSize,
        ),
        Text(
          iconLabel,
          style: TextStyle(
            fontSize: textSize,
          ),
        )
      ],
    );
  }
}
