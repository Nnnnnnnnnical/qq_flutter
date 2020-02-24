/*
 * @Description: 动态基础页面
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-02 21:14:51
 * @LastEditTime : 2020-02-11 17:21:38
 * @LastEditors  : Please set LastEditors
 * @LastEmail: gdutlikai@163.com
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qq/ui/mydrawer.dart';
import 'package:qq/ui/serach_content.dart';
import 'package:qq/ui/avatar_pic.dart';

class Activity extends StatefulWidget {
  Activity({Key key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: AvatarPic(
              scaffoldKey: _scaffoldKey,
            ),
            title: Text("动态"),
            centerTitle: true
          ),
          drawer: MyDrawer(),
          body: ListView(
            children: <Widget>[
              SearchContent(),
              Container(
                child: Column(
                  children: <Widget>[
                    _personItem('zone.png', '我的空间'),
                    _divider(),
                    _personItem('album.png','相册'),
                    _personItem('picture.png','图册'),
                    _divider(),
                    _personItem('fans.png', '花粉'),
                    _personItem('video.png','直播'),
                    _personItem('secret.png', '悄悄话'),
                    _personItem('talk.png', '我聊'),
                    _personItem('topnews.png', '最新资讯'),
                  ],
                ),
              )
            ],
          ),
          resizeToAvoidBottomPadding: false,
        ),
      ),
    );
  }
}

Container _divider() {
    return  Container(
        height: 15.0,
        color: const Color.fromRGBO(221, 221, 221, 0.5),
    );
  }

   Container _personItem(String imgAsset, String title,
      {VoidCallback onTab}) {
    return Container(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Image.asset(
                "images/" + imgAsset,
                width: 25.0,
                height: 25.0,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 17.0),
              ),
            ),
            _rightArrow()
          ],
        ),
        onTap: onTab,
      ),
    );
  }

    _rightArrow() {
    return Icon(
      Icons.chevron_right,
      color: const Color.fromARGB(255, 204, 204, 204),
    );
  }