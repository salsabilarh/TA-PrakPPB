import 'package:quranpulse/animations/bottom_animation.dart';
import 'package:quranpulse/configs/app.dart';
import 'package:quranpulse/configs/configs.dart';
import 'package:quranpulse/cubits/juz/cubit.dart';
import 'package:quranpulse/screens/surah/surah_index_screen.dart';
import 'package:quranpulse/utils/assets.dart';
import 'package:quranpulse/utils/juz.dart';
import 'package:quranpulse/widgets/custom_image.dart';
import 'package:quranpulse/widgets/app/title.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/rendering.dart';

class JuzIndexScreen extends StatefulWidget {
  const JuzIndexScreen({Key? key}) : super(key: key);

  @override
  State<JuzIndexScreen> createState() => _JuzIndexScreenState();
}

class _JuzIndexScreenState extends State<JuzIndexScreen> {
  int _searchedIndex = -1;
  String _searchedJuzName = '';

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final juzCubit = JuzCubit.cubit(context);

    bool hasSearched = _searchedIndex != -1 && _searchedJuzName.isNotEmpty;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white, // Warna latar belakang app bar
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.black), // Ikon tombol kembali
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Fungsi kembali ke halaman sebelumnya
            },
          ),
          elevation: 0, // Menghilangkan bayangan pada app bar
        ),
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            Container(
              height: AppDimensions.normalize(20),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
                left: AppDimensions.normalize(5),
                right: AppDimensions.normalize(5),
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      _searchedIndex = -1;
                      _searchedJuzName = '';
                    });
                  }
                  if (value.isNotEmpty) {
                    if (value.length <= 2) {
                      setState(() {
                        _searchedIndex = int.parse(value);
                        if (_searchedIndex <= JuzUtils.juzNames.length &&
                            _searchedIndex >= 0) {
                          _searchedJuzName =
                              JuzUtils.juzNames[_searchedIndex - 1];
                        }
                      });
                    }
                  }
                },
                decoration: InputDecoration(
                  contentPadding: Space.h,
                  hintText: 'Search Juz Number here...',
                  hintStyle: AppText.b2!.copyWith(
                    color: AppTheme.c!.textSub2,
                  ),
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: AppTheme.c!.textSub2!,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.c!.textSub2!,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.c!.textSub2!,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.28,
              ),
              child: hasSearched
                  ? GestureDetector(
                      onTap: () async {
                        await juzCubit.fetch(
                          JuzUtils.juzNames.indexOf(_searchedJuzName) + 1,
                        );

                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PageScreen(
                                juz: juzCubit.state.data,
                              ),
                            ),
                          );
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _searchedJuzName,
                                style: AppText.h2b,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : GridView.builder(
                      itemCount: JuzUtils.juzNames.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return WidgetAnimator(
                          child: InkWell(
                            onTap: () async {
                              await juzCubit.fetch(index + 1);

                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PageScreen(
                                      juz: juzCubit.state.data,
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                    color: Colors.black38,
                                    width: 1,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      JuzUtils.juzNames[index],
                                      style: AppText.b1b,
                                      textAlign: TextAlign.center,
                                    ),
                                    Space.y!,
                                    Text(
                                      '${index + 1}',
                                      style: AppText.b2b,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            mouseCursor: SystemMouseCursors.click,
                          ),
                        );
                      },
                    ),
            ),
            CustomImage(
              opacity: 0.3,
              height: AppDimensions.normalize(60),
              imagePath: StaticAssets.quranRail,
            ),
            const CustomTitle(
              title: "Juz Index",
            ),
          ],
        )),
      ),
    );
  }
}
