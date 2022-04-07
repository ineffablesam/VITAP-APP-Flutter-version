import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:news_app/blocs/videos_bloc.dart';
import 'package:news_app/cards/card4.dart';
import 'package:news_app/cards/card5.dart';
import 'package:news_app/utils/empty.dart';
import 'package:news_app/utils/loading_cards.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class VideoArticles extends StatefulWidget {
  VideoArticles({Key? key}) : super(key: key);

  @override
  _VideoArticlesState createState() => _VideoArticlesState();
}

class _VideoArticlesState extends State<VideoArticles>
    with AutomaticKeepAliveClientMixin {
  ScrollController? controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _orderBy = 'timestamp';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0)).then((value) {
      controller = new ScrollController()..addListener(_scrollListener);
      context.read<VideosBloc>().getData(mounted, _orderBy);
    });
  }

  @override
  void dispose() {
    controller!.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final db = context.read<VideosBloc>();

    if (!db.isLoading) {
      if (controller!.position.pixels == controller!.position.maxScrollExtent) {
        context.read<VideosBloc>().setLoading(true);
        context.read<VideosBloc>().getData(mounted, _orderBy);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final vb = context.watch<VideosBloc>();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('GPA Caluculator').tr(),
          elevation: 5,
        ),
        body: Center(child: GPACaluculator(5)));
  }

  @override
  bool get wantKeepAlive => true;
}

class GPACaluculator extends StatefulWidget {
  final int n;
  GPACaluculator(this.n);

  @override
  State<GPACaluculator> createState() => _GPACaluculatorState();
}

class _GPACaluculatorState extends State<GPACaluculator> {
  List<String> _items =
      ['S', 'A+', 'A', 'B+', 'B', 'C', 'D', 'F/Ab/I'].toList();
  List<String> _itemsCp = ['1', '2', '3', '4', '5'].toList();
  var _selection;
  var _selectionCp;
  var list;

  @override
  void initState() {
    super.initState();
    _selection = List<String>.filled(widget.n, "0");
    _selectionCp = List<String>.filled(widget.n, "0");
    list = new List<int>.generate(widget.n, (i) => i);
  }

  @override
  Widget build(BuildContext context) {
    int sogxc = 0, soc = 0;
    var textFields = <Widget>[];
    bool safeToNavigate = true;
    textFields.add(
      new Row(children: [
        new Padding(
          padding: new EdgeInsets.only(left: 96.0),
        ),
        new Column(children: [
          new Text(
            "Grade",
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
        ]),
        new Padding(
          padding: new EdgeInsets.only(left: 62.0),
        ),
        new Column(
          children: [
            new Text(
              "Credits",
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
          ],
        ),
        new Padding(
          padding: new EdgeInsets.only(bottom: 25.0),
        ),
      ]),
    );
    list.forEach((i) {
      textFields.add(
        new Column(
          children: [
            new Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Text(
                    "Subject ${i + 1}:",
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(10.0),
                  ),
                  new DropdownButton<String>(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    hint: new Text(
                      "grade ${i + 1}",
                    ),
                    value: _selection[i] == "0" ? null : _selection[i],
                    items: _items.map((String item) {
                      return new DropdownMenuItem<String>(
                        value: item,
                        child: new Text(
                          item,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            color: Colors.purple[400],
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (s) {
                      setState(() {
                        _selection[i] = s;
                      });
                    },
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(25.0),
                  ),
                  new DropdownButton<String>(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    hint: new Text(
                      "credit ${i + 1}",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    value: _selectionCp[i] == "0" ? null : _selectionCp[i],
                    items: _itemsCp.map((String items) {
                      return new DropdownMenuItem<String>(
                        value: items,
                        child: new Text(
                          items,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      );
                    }).toList(),
                    onChanged: (s) {
                      setState(() {
                        _selectionCp[i] = s;
                      });
                    },
                  ),
                ]),
          ],
        ),
      );
    });

    double res = 0.0;

    return new Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.transparent, width: 30.0)),
        child: new ListView(
          children: textFields,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Calculate',
        backgroundColor: Colors.deepOrangeAccent,
        child: new Icon(Icons.gavel),
        onPressed: () {
          for (int i = 0; i < widget.n; i++) {
            if (_selectionCp[i] == null) {
              safeToNavigate = false;
              continue;
            }
            if (_selection[i] == null) {
              safeToNavigate = false;
              continue;
            }
            int r = int.parse(_selectionCp[i]);
            int gp = calculate(_selection[i]);
            int cp = r;
            int gxc = gp * cp;
            sogxc += gxc;
            soc += cp;
          }
          res = sogxc / soc;
          if (safeToNavigate)
            showRes(res);
          else {
            alert();
          }
        },
      ),
    );
  }

  int calculate(var a) {
    if (a == "O") return 10;
    if (a == "A+") return 9;
    if (a == "A") return 8;
    if (a == "B+") return 7;
    if (a == "B") return 6;
    if (a == "C") return 5;
    if (a == "P") return 4;
    if (a == "F/Ab/I") return 0;
    return 0;
  }

  Future<Null> showRes(double num) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('GPA'),
          content: new SingleChildScrollView(
            child: Text("$num"),
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text('retry'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Null> alert() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Rewind and remember'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('You have done something terrible.'),
                new Text('Go back and reflect on your mistakes.'),
              ],
            ),
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text('retry'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
