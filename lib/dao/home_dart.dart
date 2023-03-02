import 'package:async/async.dart';
import 'package:flutter_ctrip_project/model/home_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

// 首页接口
class HomeDao{
  static Future<HomeModel> fetch() async {
    // Uri url = Uri(HOME_URL);
    // var httpUrl = Url(HOME_URL);
    final response = await http.get(Uri.parse(HOME_URL));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    }else {
      throw Exception('Failed to load home_page.json');
    }
  }
}