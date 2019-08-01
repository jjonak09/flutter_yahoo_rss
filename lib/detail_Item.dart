import 'package:http/http.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

// 選択した項目の内容表示
class ItemDetailsPage extends StatefulWidget {
  final String title;
  final String url;
  final RssItem item;

  ItemDetailsPage({
    @required this.item,
    @required this.title,
    @required this.url
  });

  @override
  _ItemDetails createState() => _ItemDetails(item:item);
}
class _ItemDetails extends State<ItemDetailsPage>{
  RssItem item;
  Widget _widget = Text('wait...',);
  _ItemDetails({@required this.item});
  @override
  void initState(){
    super.initState();
    getItem();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: _widget,
    );
  }


  //RssItemの情報からコンテンツを取得し
  //Cardを作成する
  void getItem() async {
    Response res = await get(item.link);
    dom.Document doc = dom.Document.html(res.body);
    dom.Element hbody = doc.querySelector('.tpcNews_summary');
    dom.Element htitle = doc.querySelector('.tpcNews_title');
    dom.Element newslink = doc.querySelector('.tpcNews_detailLink a');
//    print(item.link);
    setState(() {
      _widget = SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                    htitle.text,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                    hbody.text,
                    style: TextStyle(
                      fontSize: 22.0,
                    )
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text('続きを読む...',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onPressed: (){
                    launch(newslink.attributes['href']);
                  },
                ),
              ),

            ],
          ),
        ),
      );
    });
  }
}