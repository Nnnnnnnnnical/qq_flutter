/*
 * @Description: 所有bottom导航的入口
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-02 17:27:33
 * @LastEditTime : 2020-02-11 16:11:05
 * @LastEditors  : Please set LastEditors
 * @LastEmail: gdutlikai@163.com
 */
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:qq/provide/websocket.dart';
import 'pages/message.dart';
import 'pages/contacts.dart';
import 'pages/watch.dart';
import 'pages/activity.dart';



class Tabs extends StatefulWidget {

  // final parentContext;
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  List _pageList= [
    Message(),
    Contacts(),
    Watch(),
    Activity(),
  ];


  @override
  Widget build(BuildContext context) {
    
    return Provide<WebSocketProvide>(builder: (context, child, val) {
      int count = 0;
      String msgCount = '';
      List messageList = Provide.value<WebSocketProvide>(context).messageList;
      for(int i = 0;i<messageList.length;i++){
        count += messageList[i].unreadMsgCount;
      }
      msgCount = count.toString();
      return Scaffold(
        body: this._pageList[this._currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap: (int index){
              setState(() {
                this._currentIndex = index;
              });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(             
             icon: Badge(               
              badgeContent: Text(
                "${msgCount}",
                style: TextStyle(color: Colors.white),
              ),
              child:Icon(Icons.message),
              showBadge: count != 0,
             ),
             title: Text("消息"), 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              title: Text("联系人"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.looks),
              title: Text("看点"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_activity),
              title: Text("动态"),
            ),
            
          ],
        ),
    );
    });
  }
}