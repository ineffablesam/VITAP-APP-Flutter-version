import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:news_app/models/article.dart';
import 'package:easy_localization/easy_localization.dart';

class ViewsCount extends StatefulWidget {

  final Article article;
  const ViewsCount({
    Key? key, required this.article,
  }) : super(key: key);

  @override
  _ViewsCountState createState() => _ViewsCountState();
}

class _ViewsCountState extends State<ViewsCount> {

  @override
  void initState() {
    _viewsIncrement();
    super.initState();
  }

  _viewsIncrement ()async{
    final DocumentReference ref = FirebaseFirestore.instance.collection('contents').doc(widget.article.timestamp);
    Future.delayed(Duration(seconds: 2)).then((value) async{
      await getLatestCount().then((int latestCount) async{
        await ref.update({
          'views': latestCount+ 1,
        });
      });
    }); 
  }


  Future<int> getLatestCount () async {
    if(widget.article.views != null){
      final String fieldName = 'views';
      final DocumentReference ref = FirebaseFirestore.instance.collection('contents').doc(widget.article.timestamp);
      DocumentSnapshot snap = await ref.get();
      int itemCount = snap[fieldName] ?? 0;
       return itemCount;
    }else{
      return 0;
    }
    
  }


  @override
  Widget build(BuildContext context) {
    final String collectionName = 'contents';
    final String documentName = widget.article.timestamp!; 
    
    return Container(
      child: Row(
        children: [
          Icon(Feather.eye, color: Colors.grey, size: 20,),
          SizedBox(width: 3,),

          widget.article.views == null 
          ? Text(0.toString())
          : StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(collectionName)
              .doc(documentName)
              .snapshots(),
          builder: (context, AsyncSnapshot snap) {
            if (!snap.hasData)
              return Text(
                0.toString(),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              );
            return Text(
              snap.data['views'].toString(),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
            );
            },
          ),

          SizedBox(width: 3,),

          Text('views',
            maxLines: 1,
            style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ).tr()
        ],
      ),
    );
  }
}