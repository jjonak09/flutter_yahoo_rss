import 'package:flutter/material.dart';

import 'rss_item.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Generated App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: const Color(0xFFe91e63),
        accentColor: const Color(0xFFe91e63),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: RssListPage(),
    );
  }
}

// Yahoo Rssの一覧リスト
class RssListPage extends StatelessWidget{
  final List<String> names = [
    '主要ニュース',
    '国際情勢',
    'IT関係',
    '国内の出来事'
  ];
  final List<String> links = [
    'https://news.yahoo.co.jp/pickup/rss.xml',
    'https://news.yahoo.co.jp/pickup/world/rss.xml',
    'https://news.yahoo.co.jp/pickup/computer/rss.xml',
    'https://news.yahoo.co.jp/pickup/domestic/rss.xml',
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Yahoo! Checker!'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: items(context),
        ),
      ),
    );
  }

  //Listに表示するListTitleのリストをつくる

  List<Widget> items(BuildContext context){
    List<Widget> items = [];
    for (var i = 0; i < names.length; i++){
      items.add(
          ListTile(
            contentPadding: EdgeInsets.all(10.0),
            title: Text(names[i],
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MyRssPage(
                      title: names[i],
                      url: links[i]
                  ) ,
                ),
              );
            },
          )
      );
    }
    return items;
  }
}
