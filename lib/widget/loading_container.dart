import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget{
  final Widget? child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer({Key? key, this.child,required this.isLoading, this.cover = false}):super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return !cover?!isLoading?child!:_loadingView:Stack(
      children: <Widget>[
          child!,
          isLoading?_loadingView:Container(width: 0,height: 0,)
      ],
    );
  }
  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}