import 'package:flutter/material.dart';
import 'package:news_app/blocs/popular_articles_bloc.dart';
import 'package:news_app/cards/card1.dart';
import 'package:news_app/models/categories2.dart';
import 'package:news_app/pages/category_card.dart';
import 'package:news_app/pages/more_articles.dart';
import 'package:news_app/routes.dart';
import 'package:news_app/utils/loading_cards.dart';
import 'package:news_app/utils/next_screen.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';

import '../constants/categories.dart';

class PopularArticles extends StatelessWidget {
  PopularArticles({Key? key}) : super(key: key);

  void _onSelectCategory(Category categorys) {
    AppNavigator.push(categorys.route);
  }

  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(28, 42, 28, 62),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
        mainAxisSpacing: 15,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryCard(
          categories[index],
          onPress: () => _onSelectCategory(categories[index]),
        );
      },
    );
  }
}
