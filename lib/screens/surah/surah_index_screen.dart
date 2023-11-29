import 'package:quranpulse/animations/bottom_animation.dart';
import 'package:quranpulse/configs/app.dart';
import 'package:quranpulse/configs/configs.dart';
import 'package:quranpulse/cubits/bookmarks/cubit.dart';
import 'package:quranpulse/cubits/chapter/cubit.dart';
import 'package:quranpulse/models/chapter/chapter.dart';
import 'package:quranpulse/models/juz/juz.dart';
import 'package:quranpulse/utils/assets.dart';
import 'package:quranpulse/utils/juz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quranpulse/widgets/app/title.dart';
import 'package:quranpulse/widgets/custom_image.dart';

part '../page/page_screen.dart';

part 'widgets/surah_tile.dart';
part 'widgets/surah_app_bar.dart';
part 'widgets/surah_information.dart';

class SurahIndexScreen extends StatefulWidget {
  const SurahIndexScreen({Key? key}) : super(key: key);

  @override
  State<SurahIndexScreen> createState() => _SurahIndexScreenState();
}

class _SurahIndexScreenState extends State<SurahIndexScreen> {
  List<Chapter?>? chapters = [];
  List<Chapter?>? searchedChapters = [];

  @override
  void initState() {
    final chapterCubit = ChapterCubit.cubit(context);
    chapters = chapterCubit.state.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final chapterCubit = ChapterCubit.cubit(context);

    double height = MediaQuery.of(context).size.height;

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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              CustomImage(
                opacity: 0.3,
                height: height * 0.17,
                imagePath: StaticAssets.kaba,
              ),
              const CustomTitle(
                title: 'Surah Index',
              ),
              if (chapters!.isEmpty)
                Center(
                  child: BlocBuilder<ChapterCubit, ChapterState>(
                    builder: (context, state) {
                      if (state is ChapterFetchLoading) {
                        return LinearProgressIndicator(
                          backgroundColor: AppTheme.c!.accent,
                          valueColor:
                              const AlwaysStoppedAnimation(Colors.white),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: AppDimensions.normalize(25),
                          ),
                          Space.y!,
                          Text(
                            'Something went wrong!',
                            style: AppText.h3b,
                          ),
                          Space.y1!,
                          SizedBox(
                            width: AppDimensions.normalize(70),
                            height: AppDimensions.normalize(17),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  AppTheme.c!.accent,
                                ),
                              ),
                              onPressed: () {
                                chapterCubit.fetch(api: true);
                              },
                              child: const Text('Retry'),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              if (chapters!.isNotEmpty)
                Container(
                  height: AppDimensions.normalize(20),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2,
                    left: AppDimensions.normalize(5),
                    right: AppDimensions.normalize(5),
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          searchedChapters = [];
                        });
                      }
                      if (value.isNotEmpty) {
                        setState(() {
                          var lowerCaseQuery = value.toLowerCase();

                          searchedChapters = chapters!.where((chapter) {
                            final chapterName = chapter!.englishName!
                                .toLowerCase()
                                .contains(lowerCaseQuery);
                            return chapterName;
                          }).toList(growable: false)
                            ..sort(
                              (a, b) => a!.englishName!
                                  .toLowerCase()
                                  .indexOf(lowerCaseQuery)
                                  .compareTo(
                                    b!.englishName!
                                        .toLowerCase()
                                        .indexOf(lowerCaseQuery),
                                  ),
                            );
                        });
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: Space.h,
                      hintText: 'Cari nama surah..',
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
              if (chapters!.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28,
                  ),
                  child: searchedChapters!.isNotEmpty
                      ? ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            color: Color(0xffee8f8b),
                          ),
                          itemCount: searchedChapters!.length,
                          itemBuilder: (context, index) {
                            final chapter = searchedChapters![index];
                            return SurahTile(
                              chapter: chapter,
                            );
                          },
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            color: Color(0xffee8f8b),
                          ),
                          itemCount: chapters!.length,
                          itemBuilder: (context, index) {
                            final chapter = chapters![index];
                            return SurahTile(
                              chapter: chapter,
                            );
                          },
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
