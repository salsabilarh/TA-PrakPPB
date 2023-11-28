import 'package:quranpulse/utils/assets.dart';
import 'package:flutter/material.dart';

class DrawerAppName extends StatelessWidget {
  const DrawerAppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "\nThe",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: height * 0.025,
                color: Colors.black87,
              ),
            ),
            Text(
              "QuranPulse",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: height * 0.035,
              ),
            )
          ],
        ),
        Image.asset(
          StaticAssets.gradLogo,
          height: height * 0.17,
        )
      ],
    );
  }
}
