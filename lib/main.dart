/*
 * @Description: 主入口
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-02 17:16:31
 * @LastEditTime: 2020-01-16 17:00:53
 * @LastEditors: leooooli
 * @LastEmail: gdutlikai@163.com
 */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:qq/provide/currentIndex.dart';
import 'package:qq/provide/websocket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'index.dart';
// void main() => runApp(MyApp());

void main() {
  var providers = Providers();
  var currentIndexProvide = CurrentIndexProvide();
  var websocketProvide = WebSocketProvide();
  providers
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<WebSocketProvide>.value(websocketProvide));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provide.value<WebSocketProvide>(context).init();
    return MaterialApp(
      title: "qq-高仿",
      debugShowCheckedModeBanner: false,  // 去掉debug标签
      home: new Tabs(),
    );
  }
}
