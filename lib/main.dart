import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:quranpulse/cubits/bookmarks/cubit.dart';
import 'package:quranpulse/cubits/chapter/cubit.dart';
import 'package:quranpulse/cubits/juz/cubit.dart';
import 'package:quranpulse/models/ayah/ayah.dart';
import 'package:quranpulse/models/chapter/chapter.dart';
import 'package:quranpulse/models/juz/juz.dart';
import 'package:quranpulse/providers/app_provider.dart';
import 'package:quranpulse/screens/bookmarks/bookmarks_screen.dart';
import 'package:quranpulse/screens/home/home_screen.dart';
import 'package:quranpulse/screens/juz/juz_index_screen.dart';
import 'package:quranpulse/screens/splash/splash.dart';
import 'package:quranpulse/screens/profile/profile.dart';
import 'package:quranpulse/screens/surah/surah_index_screen.dart';

import 'configs/core_theme.dart' as theme;

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

// hive
  await Hive.initFlutter();

  Hive.registerAdapter<Juz>(JuzAdapter());
  Hive.registerAdapter<Ayah>(AyahAdapter());
  Hive.registerAdapter<Chapter>(ChapterAdapter());

  await Hive.openBox('app');
  await Hive.openBox('data');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => JuzCubit()),
        BlocProvider(create: (_) => ChapterCubit()),
        BlocProvider(create: (_) => BookmarkCubit()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: ((context, value, child) {
          return MaterialChild(
            value: value,
          );
        }),
      ),
    );
  }
}

class MaterialChild extends StatelessWidget {
  final AppProvider? value;
  const MaterialChild({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'quranpulse',
      debugShowCheckedModeBanner: false,
      theme: theme.themeLight,
      themeMode: value!.themeMode,
      home: Builder(
        builder: (context) => HomeScreen(
          maxSlide: MediaQuery.of(context).size.width * 0.835,
        ),
      ),
      initialRoute: '/splash',
      routes: <String, WidgetBuilder>{
        '/juz': (context) => const JuzIndexScreen(),
        '/splash': (context) => const SplashScreen(),
        '/surah': (context) => const SurahIndexScreen(),
        '/bookmarks': (context) => const BookmarksScreen(),
        '/profile': (context) => const Profile(),
        '/home': (context) =>
            HomeScreen(maxSlide: MediaQuery.of(context).size.width * 0.835),
      },
    );
  }
}
