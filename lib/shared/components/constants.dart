import 'package:flutter/material.dart';
import 'package:shop_pp/modules/login/login_screen.dart';
import 'package:shop_pp/shared/components/components.dart';
import 'package:shop_pp/shared/network/local/cacheHelper.dart';

const default_color=Colors.blue;

void SignOut(context){
  CacheHelper.removeData(key: 'token').then((value) => {
    navigateToAndFinish(context,LoginScreen())
  });
}

void printFullText(dynamic text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String token=CacheHelper.getData(key: 'token');