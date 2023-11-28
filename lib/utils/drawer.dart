import 'package:quranpulse/app_routes.dart';
import 'package:iconsax/iconsax.dart';

class DrawerUtils {
  static const List items = [
    {
      'title': 'Juz Index',
      'icon': Iconsax.note_1,
      'route': AppRoutes.juz,
    },
    {
      'title': 'Surah Index',
      'icon': Iconsax.sort,
      'route': AppRoutes.surah,
    },
    {
      'title': 'Bookmarks',
      'icon': Iconsax.book_1,
      'route': AppRoutes.bookmarks,
    },
    {
      'title': 'Profile',
      'icon': Iconsax.profile_circle,
      'route': AppRoutes.profile,
    },
  ];
}
