import 'package:flutter/material.dart';
import 'package:news_app/blocs/related_articles_bloc.dart';
import 'package:news_app/cards/card3.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class RelatedArticles extends StatefulWidget {
  final String? category;
  final String? timestamp;
  final bool? replace;
  RelatedArticles(
      {Key? key, required this.category, required this.timestamp, this.replace})
      : super(key: key);

  @override
  _RelatedArticlesState createState() => _RelatedArticlesState();
}

class _RelatedArticlesState extends State<RelatedArticles> {
  @override
  void initState() {
    super.initState();
    context.read<RelatedBloc>().getData(widget.category, widget.timestamp);
  }

  @override
  Widget build(BuildContext context) {
    final rb = context.watch<RelatedBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 8),
          height: 3,
          width: 100,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(40)),
        ),
      ],
    );
  }
}
