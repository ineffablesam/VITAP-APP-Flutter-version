import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/models/article.dart';

class FeaturedBloc with ChangeNotifier {


  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Article> _data = [];
  List<Article> get data => _data;

  List featuredList  = [];

  bool _hasData = true;
  bool get hasData => _hasData;


  Future<List> _getFeaturedList ()async{
    final DocumentReference ref = firestore.collection('featured').doc('featured_list');
      DocumentSnapshot snap = await ref.get();
      featuredList = snap['contents'] ?? [];
      if(featuredList.isNotEmpty){
        List<int> a = featuredList.map((e) => int.parse(e)).toList()..sort();
        List<String> b = a.take(10).toList().map((e) => e.toString()).toList();
        return b;
      }else{
        return featuredList;
      }
  }


  Future getData() async {
    _getFeaturedList()
    .then((featuredList) async {
      QuerySnapshot rawData;
      rawData = await firestore
          .collection('contents')
          .where('timestamp', whereIn: featuredList)
          .limit(10)
          .get();
      
      List<DocumentSnapshot> _snap = [];
      _snap.addAll(rawData.docs);
      _data = _snap.map((e) => Article.fromFirestore(e)).toList();
      _data.sort((a,b) => b.timestamp!.compareTo(a.timestamp!));
      if(_data.isEmpty){
        _hasData = false;
      }else{
        _hasData = true;
      }
      notifyListeners();
    }).onError((error, stackTrace){
      _hasData = false;
      notifyListeners();
    });
    
  }


  onRefresh (){
    featuredList.clear();
    _data.clear();
    _hasData = true;
    getData();
    notifyListeners();
  }






}
