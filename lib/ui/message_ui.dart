/*
 * @Description: 消息界面消息列表UI
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-06 11:51:36
 * @LastEditTime : 2020-02-12 11:32:33
 * @LastEditors: Please set LastEditors
 * @LastEmail: gdutlikai@163.com
 */
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:qq/common/constant.dart';
import 'package:qq/pages/chat.dart';
import 'package:qq/provide/touch_move_paint.dart';
import 'package:qq/provide/websocket.dart';

class MessageUi extends StatefulWidget {
  MessageUi({Key key}) : super(key: key);

  @override
  _MessageUiState createState() => _MessageUiState();
}

class _MessageUiState extends State<MessageUi> {

  TouchMovePainter painter;
  List originOffset = [];

  //本次移动的offset
  List moveOffset = [];
  //最后一次down事件的offset
  List lastStartOffset = [];

  List _messageList = new List();

  Constant constant = new Constant();
  Offset offset = Offset(0.0, 0.0); //初始化offset位置
  Color widgetColor;

  @override
  void initState() {
    painter = TouchMovePainter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<WebSocketProvide>(builder: (context, child, val) {
      var tmp = Provide.value<WebSocketProvide>(context).messageList;     
      _messageList = tmp;
      //消息列表顺序排序
      _messageList.sort((left, right) {
        int leftTime = 0, rightTime = 0;
        if (left.updateAt != "") {
          leftTime = DateTime.parse(left.updateAt).millisecondsSinceEpoch;
        }
        if (right.updateAt != "") {
          rightTime = DateTime.parse(right.updateAt).millisecondsSinceEpoch;
        }

        return rightTime.compareTo(leftTime);
      });

      //constant.orderMessage来记录排序前后消息列表的位置，key为排序前，value为排序后
      for(int i = 0;i<constant.messageList.length;i++){
          constant.orderMessage[i] = _messageList[i].id;
      }
      //如果messageList数据有新增
      if(constant.messageList.length != _messageList.length){
        for(int i = constant.messageList.length;i<_messageList.length;i++){
          constant.orderMessage.add(tmp[i].id);
        }
      }
      constant.messageList = _messageList;

      //初始化消息红点的位置数据
      for(int i = 0;i<_messageList.length;i++){
        originOffset.add(new Offset(0,0));
        moveOffset.add(new Offset(0, 0));
        lastStartOffset.add(new Offset(0, 0));
      }

      return Expanded(
        child: ListView.builder(
          itemCount: _messageList.length == 0 ? 1 : _messageList.length,
          itemBuilder: _itemBuilder,
        ),
      );
    });
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
        child: _messageList.length == 0
            ? Container()
            : InkWell(
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: SizedBox(
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(this._messageList[index].avatar),
                          ),
                          width: 50.0,
                          height: 50.0,
                        ),
                        title: Text(
                          this._messageList[index].title,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Container(
                          width: 60,
                          child: Text(
                            this._messageList[index].des,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        
                        trailing: Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.only(
                              top: 7.0, bottom: 7.0, left: 4.0, right: 8.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                child: Text(
                                  this._messageList[index].updateAt == ""
                                      ? ""
                                      : this._messageList[index].updateAt.substring(11, 16),
                                ),
                              ),
                              this._messageList[index].unreadMsgCount == 0
                                  ? Container()
                                  : Transform.translate(
                                      offset: moveOffset[index],
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        child: GestureDetector(
                                            onPanStart: (detail) {
                                              setState(() {
                                                //控制上一次开始的位置
                                                lastStartOffset[index] = detail.globalPosition;
                                              });
                                            },
                                            onPanUpdate: (detail) {
                                              setState(() {
                                                moveOffset[index] = detail.globalPosition - lastStartOffset[index];
                                                moveOffset[index] = Offset(max(0, moveOffset[index].dx),max(0, moveOffset[index].dy));
                                              });
                                            },
                                            onPanEnd: (detail) {
                                              setState(() {
                                                //控制复位
                                                moveOffset[index] = originOffset[index];
                                                this._messageList[index].unreadMsgCount = 0;
                                                Provide.value<WebSocketProvide>(context).clearMessage(index);
                                              });
                                            },
                                            child:CustomPaint(
                                              painter: painter,
                                                child: Text(
                                                  this._messageList[index].unreadMsgCount.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                            )),
                                      ),
                                    ),
                            ],
                          ),
                        )),
                  ],
                ),
                onTap: () {
                  // Navigator.of(parentContext).pushNamed('/chat');
                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                    return constant.orderMessage.length == 0 ? Chat(_messageList[index].type,index) : Chat(_messageList[index].type,constant.orderMessage[index]);
                  }));
                },
              ));
  }
}
