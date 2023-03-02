import 'package:flutter/cupertino.dart';
import 'package:flutter_ctrip_project/model/grid_nav_model.dart';
import 'package:flutter/material.dart';
class GridNav extends StatelessWidget {
  final GridNavModel? gridNavModel;
  final String name;
  const GridNav({Key? key,required this.gridNavModel, this.name = 'xiaoming'}): super (key: key);

  // _GridNavState createState() => _GridNavState(name: '11');
  @override
  Widget build(BuildContext context) {
    return Text(name);
  }

}

// class _GridNavState extends State<GridNav>{
//   final String name;
//   _GridNavState({required this.name});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text('hello');
//   }
// }