/*
 * @Description: 头像抽屉UI
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-03 16:40:37
 * @LastEditTime: 2020-01-14 14:54:53
 * @LastEditors: leooooli
 * @LastEmail: gdutlikai@163.com
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qq/model/me.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Me me = Me();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: new ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: UserAccountsDrawerHeader(
                  accountName: Text(
                    me.name,
                    style: TextStyle(fontSize: 20),
                  ),
                  accountEmail: Text("leooooli你是最棒的"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage(me.avatar), 
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        image: AssetImage("images/2.png"),
                        fit: BoxFit.cover,
                      )),
                ))
              ],
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.account_balance_wallet),
                backgroundColor: Colors.white,
              ),
              title: Text(
                "我的钱包",
                style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400),
              ),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.collections),
                backgroundColor: Colors.white,
              ),
              title: Text(
                "我的收藏",
                style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400),
              ),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.photo_album),
                backgroundColor: Colors.white,
              ),
              title: Text(
                "我的相册",
                style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400),
                
                ),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.work),
                backgroundColor: Colors.white,
              ),
              title: Text(
                "我的文档",
                style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400),
                
                ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
