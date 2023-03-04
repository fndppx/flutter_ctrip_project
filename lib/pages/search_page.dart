import 'package:flutter/material.dart';
import 'package:flutter_ctrip_project/widget/search_bar.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState()  => _SearchPageState();

}

class _SearchPageState extends State<SearchPage>{

  final PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,title: Text('搜索',style: TextStyle(fontSize: 18,color: Colors.white),),),
      body: Column(
        children: [
          SearchBar(
            hideLeft: true,
            defaultText: '哈哈',
            hint: '123',
            leftButtonClick: (){

            },
            rightButtonClick: (){

            },
            speakClick: (){

            },
            onChanged: _onTextChange(),
          ),
          // Text('11')
        ],
      )
    );
  }

  _onTextChange(){

  }
}