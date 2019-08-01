import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'detail_Item.dart';

//RSSのアイテム一覧
class MyRssPage extends StatefulWidget {
  final String title;
  final String url;

  MyRssPage({@required this.title,@required this.url});

  @override
  _MyRssPageState createState() => _MyRssPageState(title:title,url:url);
}


class _MyRssPageState extends State<MyRssPage>{
  final String title;
  final String url;

  List<Widget> _items = <Widget>[];
  _MyRssPageState({@required this.title,@required this.url}){
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: _items,
        ),
      ),
    );
  }

  // YahooサイトからRSSを取得し、
  // ListTitleのListを作る
  void getItems() async {
    List<Widget> list = <Widget>[];
    Response res = await get(url);
    RssFeed feed = RssFeed.parse(res.body);
    for (RssItem item in feed.items){
      list.add(
          ListTile(
            contentPadding: EdgeInsets.all(10.0),
            title: Text(
              item.title,
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            subtitle: Text(
              item.pubDate,
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ItemDetailsPage(
                      item: item,title:title, url:url
                  ) ,
                ),
              );
            },
          )
      );
    }
    // _itemsの更新
    setState(() {
      _items = list;
    });
  }
}