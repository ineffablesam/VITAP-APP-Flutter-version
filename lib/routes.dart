import 'package:flutter/material.dart';
import 'package:news_app/core/fade_page_route.dart';
import 'package:news_app/pages/bookmarks.dart';
import 'package:news_app/widgets/language.dart';

import 'pages/search.dart';

enum Routes { pokemonInfo, bookmarks, searchpage, items }

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String bookmarks = '/Bookmarks';
  static const String pokemonInfo = 'Home/pages';
  static const String searchpage = '/searchpage';
  static const String itemsList = 'Home/pages';

  static const Map<Routes, String> _pathMap = {
    Routes.bookmarks: _Paths.bookmarks,
    Routes.searchpage: _Paths.searchpage
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.splash:
        return FadeRoute(page: LanguagePopup());

      case _Paths.bookmarks:
        return FadeRoute(page: BookmarkPage());

      case _Paths.pokemonInfo:
        return FadeRoute(page: BookmarkPage());

      case _Paths.searchpage:
        return FadeRoute(page: SearchPage());

      case _Paths.itemsList:
        return FadeRoute(page: BookmarkPage());

      case _Paths.home:
      default:
        return FadeRoute(page: BookmarkPage());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
