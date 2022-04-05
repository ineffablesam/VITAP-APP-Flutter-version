import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/splash.dart';
import 'package:news_app/routes.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'blocs/ads_bloc.dart';
import 'blocs/article_notification_bloc.dart';
import 'blocs/bookmark_bloc.dart';
import 'blocs/categories_bloc.dart';
import 'blocs/category_tab1_bloc.dart';
import 'blocs/category_tab2_bloc.dart';
import 'blocs/category_tab3_bloc.dart';
import 'blocs/category_tab4_bloc.dart';
import 'blocs/comments_bloc.dart';
import 'blocs/custom_notification_bloc.dart';
import 'blocs/featured_bloc.dart';
import 'blocs/notification_bloc.dart';
import 'blocs/popular_articles_bloc.dart';
import 'blocs/recent_articles_bloc.dart';
import 'blocs/related_articles_bloc.dart';
import 'blocs/search_bloc.dart';
import 'blocs/sign_in_bloc.dart';
import 'blocs/tab_index_bloc.dart';
import 'blocs/theme_bloc.dart';
import 'blocs/videos_bloc.dart';
import 'models/theme_model.dart';

final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
final FirebaseAnalyticsObserver firebaseObserver =
    FirebaseAnalyticsObserver(analytics: firebaseAnalytics);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeBloc>(
      create: (_) => ThemeBloc(),
      child: Consumer<ThemeBloc>(
        builder: (_, mode, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<SignInBloc>(
                create: (context) => SignInBloc(),
              ),
              ChangeNotifierProvider<CommentsBloc>(
                create: (context) => CommentsBloc(),
              ),
              ChangeNotifierProvider<BookmarkBloc>(
                create: (context) => BookmarkBloc(),
              ),
              ChangeNotifierProvider<SearchBloc>(
                  create: (context) => SearchBloc()),
              ChangeNotifierProvider<FeaturedBloc>(
                  create: (context) => FeaturedBloc()),
              ChangeNotifierProvider<PopularBloc>(
                  create: (context) => PopularBloc()),
              ChangeNotifierProvider<RecentBloc>(
                  create: (context) => RecentBloc()),
              ChangeNotifierProvider<CategoriesBloc>(
                  create: (context) => CategoriesBloc()),
              ChangeNotifierProvider<AdsBloc>(create: (context) => AdsBloc()),
              ChangeNotifierProvider<RelatedBloc>(
                  create: (context) => RelatedBloc()),
              ChangeNotifierProvider<TabIndexBloc>(
                  create: (context) => TabIndexBloc()),
              ChangeNotifierProvider<NotificationBloc>(
                  create: (context) => NotificationBloc()),
              ChangeNotifierProvider<CustomNotificationBloc>(
                  create: (context) => CustomNotificationBloc()),
              ChangeNotifierProvider<ArticleNotificationBloc>(
                  create: (context) => ArticleNotificationBloc()),
              ChangeNotifierProvider<VideosBloc>(
                  create: (context) => VideosBloc()),
              ChangeNotifierProvider<CategoryTab1Bloc>(
                  create: (context) => CategoryTab1Bloc()),
              ChangeNotifierProvider<CategoryTab2Bloc>(
                  create: (context) => CategoryTab2Bloc()),
              ChangeNotifierProvider<CategoryTab3Bloc>(
                  create: (context) => CategoryTab3Bloc()),
              ChangeNotifierProvider<CategoryTab4Bloc>(
                  create: (context) => CategoryTab4Bloc()),
            ],
            child: MaterialApp(
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              navigatorObservers: [firebaseObserver],
              theme: ThemeModel().lightMode,
              darkTheme: ThemeModel().darkMode,
              themeMode:
                  mode.darkTheme == true ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: SplashPage(),
              navigatorKey: AppNavigator.navigatorKey,
              onGenerateRoute: AppNavigator.onGenerateRoute,
            ),
          );
        },
      ),
    );
  }
}
