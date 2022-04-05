import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/recent_articles_bloc.dart';
import 'package:news_app/cards/card2.dart';
import 'package:news_app/cards/card4.dart';
import 'package:news_app/cards/card5.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class RecentArticles extends StatefulWidget {
  RecentArticles({Key? key}) : super(key: key);

  @override
  _RecentArticlesState createState() => _RecentArticlesState();
}

class _RecentArticlesState extends State<RecentArticles> {
  final List<String> _listItem = [
    'assets/images/two.jpg',
    'assets/images/three.jpg',
    'assets/images/four.jpg',
    'assets/images/five.jpg',
    'assets/images/one.jpg',
    'assets/images/two.jpg',
    'assets/images/three.jpg',
    'assets/images/four.jpg',
    'assets/images/five.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final rb = context.watch<RecentBloc>();

    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[],
            )),
      ],
    );
  }
}
