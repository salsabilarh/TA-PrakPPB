import 'package:flutter/material.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({Key? key}) : super(key: key);

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "QuranPulse: Enlighten Your Soul",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: MediaQuery.of(context).size.height * 0.018),
          ),
        ],
      ),
    );
  }
}
