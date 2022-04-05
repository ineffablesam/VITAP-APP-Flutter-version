import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/pages/article_details.dart';
import 'package:news_app/pages/video_article_details.dart';

void nextScreen (context, page){
  Navigator.push(context, MaterialPageRoute(
    builder: (context) => page));
}


void nextScreeniOS (context, page){
  Navigator.push(context, CupertinoPageRoute(
    builder: (context) => page));
}


void nextScreenCloseOthers (context, page){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

void nextScreenReplace (context, page){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
}


void nextScreenPopup (context, page){
  Navigator.push(context, MaterialPageRoute(
    fullscreenDialog: true,
    builder: (context) => page),
  );
}

void navigateToDetailsScreen (context, Article article, String? heroTag){
  if(article.contentType == 'video'){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => VideoArticleDetails(data: article)),
    );
    
  }else{
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ArticleDetails(data: article, tag: heroTag,)),
    );
  }
}


void navigateToDetailsScreenByReplace (context, Article article, String? heroTag, bool? replace){
  if(replace == null || replace == false){
    navigateToDetailsScreen(context, article, heroTag);
  }else{
    if(article.contentType == 'video'){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => VideoArticleDetails(data: article)),
      );
    
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => ArticleDetails(data: article, tag: heroTag,)),
      );
    }
  }
}