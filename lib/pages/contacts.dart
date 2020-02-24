/*
 * @Description: 联系人基础页面
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-02 20:25:25
 * @LastEditTime : 2020-01-19 15:14:29
 * @LastEditors  : Please set LastEditors
 * @LastEmail: gdutlikai@163.com
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qq/ui/avatar_pic.dart';
import 'package:qq/ui/contact_ui.dart';
import 'package:qq/ui/mydrawer.dart';
import 'package:qq/ui/serach_content.dart';

class Contacts extends StatefulWidget {
  Contacts({Key key}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: Text("联系人"),
          centerTitle: true,
          leading: AvatarPic(
            scaffoldKey: _scaffoldKey,
          ),
        ),
        drawer: MyDrawer(),
        body: GestureDetector(
          child: Column(
            children: <Widget>[
              SearchContent(),
              ContactUi(),
            ],
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
        ),
        resizeToAvoidBottomPadding: false,
    );
  }
}
