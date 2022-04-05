import 'package:flutter/material.dart';
import 'package:news_app/blocs/category_tab1_bloc.dart';
import 'package:news_app/blocs/category_tab2_bloc.dart';
import 'package:news_app/blocs/category_tab3_bloc.dart';
import 'package:news_app/blocs/category_tab4_bloc.dart';
import 'package:news_app/blocs/recent_articles_bloc.dart';
import 'package:news_app/blocs/tab_index_bloc.dart';
import 'package:news_app/config/config.dart';
import 'package:news_app/tabs/category_tab1.dart';
import 'package:news_app/tabs/category_tab2.dart';
import 'package:news_app/tabs/category_tab3.dart';
import 'package:news_app/tabs/category_tab4.dart';
import 'package:news_app/tabs/tab0.dart';
import 'package:provider/provider.dart';

class TabMedium extends StatefulWidget {
  final ScrollController? sc;
  final TabController? tc;
  TabMedium({Key? key, this.sc, this.tc}) : super(key: key);

  @override
  _TabMediumState createState() => _TabMediumState();
}

class _TabMediumState extends State<TabMedium> {
  @override
  void initState() {
    super.initState();
    this.widget.sc!.addListener(_scrollListener);
  }

  void _scrollListener() {
    final db = context.read<RecentBloc>();

    final sb = context.read<TabIndexBloc>();

    if (sb.tabIndex == 0) {
      if (!db.isLoading) {
        if (this.widget.sc!.offset >=
                this.widget.sc!.position.maxScrollExtent &&
            !this.widget.sc!.position.outOfRange) {
          print("reached the bottom");
          db.setLoading(true);
          db.getData(mounted);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tab0();
  }
}
