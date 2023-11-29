part of 'cubit.dart';
//menggunakan Hive untuk menyimpan data lokal

class BookmarksDataProvider { //mengelola akses dan manipulasi data bookmark dalam penyimpanan lokal menggunakan Hive. 
  static final cache = Hive.box('data'); //Hive adalah sebuah database key-value yang digunakan untuk menyimpan data lokal di aplikasi Flutter.

  static Future<List<Chapter?>?> fetch() async { //Mengambil daftar bookmark dari penyimpanan lokal.
    try {
      List? bookmarks = await cache.get('bookmarks');
      if (bookmarks == null) {
        bookmarks = <Chapter?>[];
        await cache.put('bookmarks', bookmarks);
      }

      final List<Chapter?> cachedBookmarks = List.from(bookmarks);
      return cachedBookmarks;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<List<Chapter?>?> addBookmark(Chapter? chapter) async { //Menambahkan chapter ke daftar bookmark yang ada di penyimpanan lokal.
    try {
      List? bookmarks = await cache.get('bookmarks');
      if (bookmarks == null) {
        bookmarks = <Chapter?>[];
        await cache.put('bookmarks', bookmarks);
      }

      final List<Chapter?> updatedBookmarks = List.from(bookmarks);
      updatedBookmarks.add(chapter);

      await cache.put('bookmarks', updatedBookmarks);
      return updatedBookmarks;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<List<Chapter?>?> removeBookmark(Chapter? chapter) async { //Menghapus chapter dari daftar bookmark yang ada di penyimpanan lokal.
    try {
      List bookmarks = await cache.get('bookmarks');

      final List<Chapter?> updatedBookmarks = List.from(bookmarks);
      updatedBookmarks.remove(chapter);

      await cache.put('bookmarks', updatedBookmarks);
      return updatedBookmarks;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<bool?> checkBookmarked(Chapter? chapter) async { //Memeriksa apakah sebuah chapter sudah ditandai sebagai bookmark.
    try {
      List bookmarks = await cache.get('bookmarks');

      final List<Chapter?> updatedBookmarks = List.from(bookmarks);
      return updatedBookmarks.contains(chapter);
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}
