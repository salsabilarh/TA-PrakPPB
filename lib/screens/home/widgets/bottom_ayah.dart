part of '../home_screen.dart';

class _AyahBottom extends StatelessWidget {
  const _AyahBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "\"Al-Qur'an sebagai Petunjuk bagi Orang Bertakwa\"",
            textAlign: TextAlign.center,
            style: AppText.b2!.copyWith(
              color: AppTheme.c!.text,
            ),
          ),
          Space.y!,
          Text(
            "Qs. Surah Al-Baqarah (1: 2)\n",
            style: AppText.l1!.copyWith(
              color: AppTheme.c!.text,
            ),
          ),
        ],
      ),
    );
  }
}
