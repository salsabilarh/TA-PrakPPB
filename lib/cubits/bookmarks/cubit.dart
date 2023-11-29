import 'package:quranpulse/models/chapter/chapter.dart'; //untuk chapter alquran
import 'package:equatable/equatable.dart'; //untuk mempermudah pembandingan objek
import 'package:flutter/cupertino.dart'; //antarmuka pengguna UI
import 'package:flutter_bloc/flutter_bloc.dart'; //mengelola keadaan aplikasi
import 'package:hive_flutter/adapters.dart'; //penyimpanan data lokal

part 'state.dart';
part 'data_provider.dart';
//menggunakan state management dari Flutter Bloc untuk mengatur perubahan-perubahan status dan akses ke data sumber eksternal yang digunakan dalam aplikasi.

class BookmarkCubit extends Cubit<BookmarkState> {
  static BookmarkCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<BookmarkCubit>(context, listen: listen);

  BookmarkCubit() : super(BookmarkDefault());  //state awal

  Future<void> fetch() async {
    emit(const BookmarkFetchLoading()); //saat permintaan berlangsung
    try {
      List<Chapter?>? data = await BookmarksDataProvider.fetch();

      emit(BookmarkFetchSuccess(data: data, isBookmarked: false));
    } catch (e) {
      emit(BookmarkFetchFailed(message: e.toString()));
    }
  }

  Future<void> updateBookmark(Chapter chapter, bool add) async { //memperbarui status bookmark
    emit(const BookmarkFetchLoading());
    try {
      List<Chapter?>? data = [];
      if (add) {
        data = await BookmarksDataProvider.addBookmark(chapter);
      } else {
        data = await BookmarksDataProvider.removeBookmark(chapter);
      }
      emit(
        BookmarkFetchSuccess(data: data, isBookmarked: add),
      );
    } catch (e) {
      emit(BookmarkFetchFailed(message: e.toString()));
    }
  }

  Future<void> checkBookmarked(Chapter chapter) async { //memeriksa apakah chapter sudah ditandai sebagai bookmark
    emit(const BookmarkFetchLoading());
    try {
      final isBookmarked = await BookmarksDataProvider.checkBookmarked(chapter);
      final data = await BookmarksDataProvider.fetch();
      emit(
        BookmarkFetchSuccess(
          data: data,
          isBookmarked: isBookmarked ?? false,
        ),
      );
    } catch (e) {
      emit(BookmarkFetchFailed(message: e.toString()));
    }
  }
}
