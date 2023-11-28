import 'package:quranpulse/configs/app_typography.dart';
import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.12,
      left: MediaQuery.of(context).size.width * 0.05,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "The",
            style: AppText.h2!.copyWith(
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          Text(
            "Quran\nPulse",
            style: AppText.h1!.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 0, 0, 0),
              height: 1.3,
            ),
          )
        ],
      ),
    );
  }
}
