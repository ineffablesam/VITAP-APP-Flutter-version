import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/notification.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:news_app/widgets/html_body.dart';

class NotificationDetails extends StatelessWidget {
  final NotificationModel data;
  const NotificationDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notification details').tr(),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 30, bottom: 15, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(CupertinoIcons.time_solid, size: 20, color: Colors.grey),
                SizedBox(
                  width: 3,
                ),
                Text(
                  data.date!,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              data.title!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 20),
              height: 3,
              width: 300,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            HtmlBodyWidget(
              content: data.description!,
              isIframeVideoEnabled: true,
              isVideoEnabled: true,
              isimageEnabled: true,
            ),
          ],
        ),
      ),
    );
  }
}
