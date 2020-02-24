/*
 * @Description: 头像UI
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-03 14:58:35
 * @LastEditTime : 2020-01-19 16:58:04
 * @LastEditors  : Please set LastEditors
 * @LastEmail: gdutlikai@163.com
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:qq/provide/websocket.dart';

class AvatarPic extends StatefulWidget {

  GlobalKey<ScaffoldState> scaffoldKey;

  AvatarPic({Key key, this.scaffoldKey});

  @override
  _AvatarPicState createState() => _AvatarPicState();
}

class _AvatarPicState extends State<AvatarPic> {
  @override
  Widget build(BuildContext context) {
    return Provide<WebSocketProvide>(builder: (context, child, val) {
      String _avatar = Provide.value<WebSocketProvide>(context).avatar;
      return Container(
        child: IconButton(
          icon: CircleAvatar(
              backgroundImage: _avatar == "" ? AssetImage("images/50.jpeg") : AssetImage(_avatar)),
          onPressed: () {
            widget.scaffoldKey.currentState.openDrawer();
          },
        ),
      );
    });

  }
}
