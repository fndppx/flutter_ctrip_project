
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ctrip_project/dao/home_dart.dart';
import 'package:flutter_ctrip_project/model/grid_nav_model.dart';
import 'package:flutter_ctrip_project/model/home_model.dart';
import 'package:flutter_ctrip_project/model/sales_box_model.dart';
import 'package:flutter_ctrip_project/pages/search_page.dart';
import 'package:flutter_ctrip_project/widget/grid_nav.dart';
import 'package:flutter_ctrip_project/widget/loading_container.dart';
import 'package:flutter_ctrip_project/widget/local_nav.dart';
import 'package:flutter_ctrip_project/widget/sales_box.dart';
import 'package:flutter_ctrip_project/widget/search_bar.dart';
import 'package:flutter_ctrip_project/widget/sub_nav.dart';
import 'package:flutter_ctrip_project/widget/webview.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_ctrip_project/model/common_model.dart';

const APPBAR_SCROLL_OFFSET = 100;
const CITY_NAMES = [ '北京', '上海', '广州', '深圳', '杭州', '苏州', '成都', '武汉', '郑州', '洛阳', '厦门', '青岛', '拉萨' ];
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState()  => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List _imageUrls = [
  //   'https://img2.baidu.com/it/u=3202947311,1179654885&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500',
  //   'https://img2.baidu.com/it/u=1301024532,2250161373&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500',
  //   'https://img2.baidu.com/it/u=3202947311,1179654885&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500'
  // ];
  double appBarAlpha = 0;
  String resultString = '';
  List<CommonModel> localNavList = [];
  List<CommonModel> gridNavList = [];
  List<CommonModel> subNavList = [];
  List<CommonModel> bannerList = [];

  GridNavModel? gridNavModel;
  SalesBoxModel? salesBoxModel;
  bool _loading = true;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState () {
    super.initState();

    _handleRefresh();
  }

  Future _handleRefresh() async {
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
        gridNavModel = model.gridNav!;
        subNavList = model.subNavList!;
        salesBoxModel = model.salesBox!;
        bannerList = model.bannerList!;
        _loading = false;
      });
    } catch (e) {
      print(e);
     setState(() {
       _loading = false;
     });
    }

    // return '';
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

  _jumpToSearch() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context){
      return const SearchPage(hint: SEARCH_BAR_DEFAULT_TEXT,);
    }));
  }

  _jumpToSpeak() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,child: Stack(children: [
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child:  RefreshIndicator(
              //TODO: 下拉刷新无效果
                onRefresh: _handleRefresh,
                child: NotificationListener(
                 onNotification:(scrollNotification){
                  if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth==0){
                    _onScroll(scrollNotification.metrics.pixels);
                 }
                 return true;
                  },
                 child: _listView
                )
            )
        ),
        _appBar
      ],),
      )
    );
  }

  Widget get _banner {
    return Container(
      height: 200,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                CommonModel model = bannerList[index];
                return WebView(url: model.url,title: model.title,hideAppBar: model.hideAppBar,);
              }));
            },
            child: Image.network(bannerList[index].icon!,fit: BoxFit.fill,),
          );
        },
        // control: const SwiperControl(),
        pagination: SwiperPagination(),
      ),
    );
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(gridNavModel: gridNavModel!),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList!),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBox: salesBoxModel!),
        ),
        Container(
          // height: 800,
            child: ListTile(
              title: Text(resultString),
            )
        ),
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //AppBar渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
              rightButtonClick: (){},
            ),
          ),
        ),
        Container(
            height: appBarAlpha > 0.2 ? 0.5 : 0,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]))
      ],
    );
  }

}