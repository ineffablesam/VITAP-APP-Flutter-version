import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/featured_bloc.dart';
import 'package:news_app/blocs/theme_bloc.dart';
import 'package:news_app/cards/featured_card.dart';
import 'package:news_app/models/custom_color.dart';
import 'package:news_app/utils/loading_cards.dart';
import 'package:provider/provider.dart';

class Featured extends StatefulWidget {
  Featured({Key? key}) : super(key: key);

  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  int listIndex = 0;

  @override
  Widget build(BuildContext context) {
    final fb = context.watch<FeaturedBloc>();
    double w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 250,
          width: w,
          child: PageView.builder(
            controller: PageController(initialPage: 0),
            scrollDirection: Axis.horizontal,
            itemCount: fb.data.isEmpty ? 1 : fb.data.length,
            onPageChanged: (index) {
              setState(() {
                listIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              if (fb.data.isEmpty) {
                if (fb.hasData == false) {
                  return _EmptyContent();
                } else {
                  return LoadingFeaturedCard();
                }
              }
              return FeaturedCard(d: fb.data[index], heroTag: 'featured$index');
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: DotsIndicator(
            dotsCount: fb.data.isEmpty ? 5 : fb.data.length,
            position: listIndex.toDouble(),
            decorator: DotsDecorator(
              color: Colors.black26,
              activeColor: Theme.of(context).primaryColorDark,
              spacing: EdgeInsets.only(left: 6),
              size: const Size.square(5.0),
              activeSize: const Size(20.0, 4.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
        )
      ],
    );
  }
}

class _EmptyContent extends StatelessWidget {
  const _EmptyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: context.watch<ThemeBloc>().darkTheme == false
              ? CustomColor().loadingColorLight
              : CustomColor().loadingColorDark,
          borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Text("No Contents found!"),
      ),
    );
  }
}
