import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget{
  String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView(this.url, this.statusBarColor, this.title, this.hideAppBar,
      this.backForbid);

  @override
  _WebViewState createState() => _WebViewState();

}

class _WebViewState extends State<WebView>{
  final webviewReference = FlutterWebviewPlugin();
  late StreamSubscription<String> _onUrlChanged;
  late StreamSubscription<WebViewStateChanged> _onStateChanged;
  late StreamSubscription<WebViewHttpError> _onHttpError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webviewReference.close();
    _onUrlChanged =webviewReference.onUrlChanged.listen((String url) {

    });
    _onStateChanged = webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch(state.type) {
        case WebViewState.shouldStart:
          // TODO: Handle this case.
          break;
        case WebViewState.startLoad:
          // TODO: Handle this case.
          break;
        case WebViewState.finishLoad:
          // TODO: Handle this case.
          break;
        case WebViewState.abortLoad:
          // TODO: Handle this case.
          break;
        default:
          break;
      }
    });

    _onHttpError = webviewReference.onHttpError.listen((WebViewHttpError error) {
      print(error);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: [
          _appBar(Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
          Expanded(child: WebviewScaffold(url: widget.url,
          withZoom: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text('Waiting...'),
              ),
            ),
          ))
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor){
    if(widget.hideAppBar??false){
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              child: Center(
              child: Text(
                widget.title??'',
                style: TextStyle(color: backButtonColor,fontSize: 20),
              ),
            ),
            left: 0,
              right: 0,)
          ],
        ),
      ),
    )
  }
}