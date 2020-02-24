/*
 * @Description: 消息基础页面
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-02 19:31:29
 * @LastEditTime : 2020-01-19 15:35:37
 * @LastEditors  : Please set LastEditors
 * @LastEmail: gdutlikai@163.com
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qq/common/check.dart';
import 'package:qq/common/win_media.dart';
import 'package:qq/ui/message_ui.dart';
import 'package:qq/ui/mydrawer.dart';
import 'package:qq/ui/popMenu/w_popup_menu.dart';
import 'package:qq/ui/serach_content.dart';
import 'package:qq/ui/avatar_pic.dart';

class Message extends StatefulWidget {
  Message({Key key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List actions = [
    {"title": '创建群聊', 'icon': 'images/add_chat.png'},
    {"title": '加好友/群', 'icon': 'images/add_friend.png'},
    {"title": '扫一扫', 'icon': 'images/get_money.png'},
    {"title": '面对面快传', 'icon': 'images/fast_pass.png'},
    {"title": '收付款', 'icon': 'images/scan.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Text("消息"),
        centerTitle: true,
        leading: AvatarPic(
          scaffoldKey: _scaffoldKey,
        ),
        actions: <Widget>[
          new WPopupMenu(
            menuWidth: winWidth(context) / 2.5,
            alignment: Alignment.center,
            onValueChanged: (String value) {
              if (!strNoEmpty(value)) return;
              // actionsHandle(value);
            },
            actions: actions,
            child: new Container(margin: EdgeInsets.symmetric(horizontal: 15.0), child: Icon(Icons.add)),
          )
        ],
      ),
      drawer: MyDrawer(),
      body: GestureDetector(
        child: Column(
          children: <Widget>[
            SearchContent(),
            MessageUi(),
          ],
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      ),
      resizeToAvoidBottomPadding: false,
    );
    // routes: <String, WidgetBuilder> {
    // '/chat': (context) => Chat(),
    // },
  }
}
