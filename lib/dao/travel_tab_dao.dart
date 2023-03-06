import 'dart:async';
import 'dart:convert';

import 'package:flutter_ctrip_project/model/home_model.dart';
import 'package:flutter_ctrip_project/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;
var Params = {
  "districtId": -1,
  "groupChannelCode": "Rx-OMF",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 0,
  "pagePara":{
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head":{},
  "contentType": "json"
};

///旅拍类别接口
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http
        .get(Uri.parse('http://www.devio.org/io/flutter_app/json/travel_page.json'));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel_page.json');
    }
  }
}
// class TravelTabDao {
//   static Future<TravelTabModel> fetch(String url, String groupChannelCode, int pageIndex,int pageSize) async {
//     Map paramsMap = Params[];
//     paramsMap['pageIndex']=pageIndex;
//     paramsMap['pageSize']=pageSize;
//     paramsMap['groupChannelCode']=groupChannelCode;
//     final response = await http
//         .post(Uri.parse('http://www.devio.org/io/flutter_app/json/travel_page.json'),body: jsonEncode(Params));
//     if (response.statusCode == 200) {
//       Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
//       var result = json.decode(utf8decoder.convert(response.bodyBytes));
//       return TravelTabModel.fromJson(result);
//     } else {
//       throw Exception('Failed to load travel_page.json');
//     }
//   }
// }


