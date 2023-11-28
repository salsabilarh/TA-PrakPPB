import 'package:quranpulse/configs/app.dart';
import 'package:quranpulse/configs/app_dimensions.dart';
import 'package:quranpulse/configs/app_theme.dart';
import 'package:quranpulse/configs/app_typography.dart';
import 'package:quranpulse/cubits/bookmarks/cubit.dart';
import 'package:quranpulse/screens/surah/surah_index_screen.dart';
import 'package:quranpulse/utils/assets.dart';
import 'package:quranpulse/widgets/custom_image.dart';
import 'package:quranpulse/widgets/loader/loading_shimmer.dart';
import 'package:quranpulse/widgets/app/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  void initState() {
    final bookmarkCubit = BookmarkCubit.cubit(context);
    bookmarkCubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final bookmarkCubit = BookmarkCubit.cubit(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Warna latar belakang app bar
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.black), // Ikon tombol kembali
          onPressed: () {
            Navigator.of(context).pop(); // Fungsi kembali ke halaman sebelumnya
          },
        ),
        elevation: 0, // Menghilangkan bayangan pada app bar
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomImage(
              opacity: 0.3,
              height: AppDimensions.normalize(60),
              imagePath: StaticAssets.sajda,
            ),
            const CustomTitle(
              title: 'Bookmarks',
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.22,
              ),
              child: BlocBuilder<BookmarkCubit, BookmarkState>(
                builder: (context, state) {
                  if (state is BookmarkFetchLoading) {
                    return const Center(
                      child: LoadingShimmer(
                        text: 'Getting your bookmarks...',
                      ),
                    );
                  } else if (state is BookmarkFetchSuccess &&
                      state.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'No Bookmarks yet!',
                        style: AppText.b1b!.copyWith(
                          color: AppTheme.c!.text,
                        ),
                      ),
                    );
                  } else if (state is BookmarkFetchSuccess) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        color: Color(0xffee8f8b),
                      ),
                      itemCount: bookmarkCubit.state.data!.length,
                      itemBuilder: (context, index) {
                        final chapter = bookmarkCubit.state.data![index];
                        return SurahTile(
                          chapter: chapter,
                        );
                      },
                    );
                  }
                  return Center(
                    child: Text(
                      state.message!,
                      style: AppText.b1b!.copyWith(
                        color: AppTheme.c!.text,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
