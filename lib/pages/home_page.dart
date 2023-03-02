
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ctrip_project/dao/home_dart.dart';
import 'package:flutter_ctrip_project/model/home_model.dart';
import 'package:flutter_ctrip_project/widget/grid_nav.dart';
import 'package:flutter_ctrip_project/widget/local_nav.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_ctrip_project/model/common_model.dart';

const APPBAR_SCROLL_OFFSET = 100;
const CITY_NAMES = [ '北京', '上海', '广州', '深圳', '杭州', '苏州', '成都', '武汉', '郑州', '洛阳', '厦门', '青岛', '拉萨' ];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState()  => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List _imageUrls = [
    'https://img2.baidu.com/it/u=3202947311,1179654885&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500',
    'https://img2.baidu.com/it/u=1301024532,2250161373&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500',
    'https://img2.baidu.com/it/u=3202947311,1179654885&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500'
  ];
  double appBarAlpha = 0;
  String resultString = '';
  List<CommonModel> localNavList = [];

  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState () {
    super.initState();

    loadData();
  }

  loadData() async {
    // HomeDao.fetch().then((result) {
    //   setState((){
    //     resultString = json.encode(result);
    //   });
    // }).catchError((e){
    //   setState((){
    //     resultString = e.toString();
    //   });
    // });

    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList!;
      });
    } catch (e) {
      print(e);
    }
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarAlpha = alpha;
    });

    print(offset);
  }


  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Stack(children: [
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child:  NotificationListener(
              onNotification:(scrollNotification){

                if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth==0){
                  _onScroll(scrollNotification.metrics.pixels);
                }

                return true;
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 200,
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      itemBuilder: (context, index) {
                        return Image.network(_imageUrls[index],fit: BoxFit.fill,);
                      },
                      // control: const SwiperControl(),
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                    child: LocalNav(localNavList: localNavList),
                  ),
                  // Container(
                  //   height: 800,
                  //   child: ListView(
                  //     children: _buildList(),
                  //   ),
                  // )


                  Container(
                    // height: 800,
                    child: ListTile(
                      title: Text(resultString),
                    )
                  ),
                  GridNav(gridNavModel: null,name: 'jack1111')
                ],
              ),
            )
        ),
        Opacity(
          opacity: appBarAlpha,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('首页'),
              ),
            ),
          ),)
      ],)
    );
  }
}