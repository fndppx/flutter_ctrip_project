import 'package:flutter/material.dart';
import 'package:flutter_ctrip_project/widget/webview.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState()  => _MyPageState();

}

class _MyPageState extends State<MyPage>{

  final PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: WebView(
        url: 'https://m.ctrip.com/webapp/myctrip/',
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '4c5bca',
      ),
    );
  }

}