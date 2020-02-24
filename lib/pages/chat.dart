/*
 * @Description: 聊天框界面
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-07 11:57:23
 * @LastEditTime : 2020-02-11 16:38:19
 * @LastEditors  : Please set LastEditors
 * @LastEmail: gdutlikai@163.com
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:qq/common/constant.dart';
import 'package:qq/model/conversation.dart';
import 'package:qq/model/me.dart';
import 'package:qq/provide/inherited_chat_input.dart';
import 'package:qq/provide/websocket.dart';
import 'package:qq/ui/chat_input.dart';

class Chat extends StatefulWidget {
  int _type;
  int _index;

  Chat(this._type,this._index);

  @override
  _ChatState createState() => _ChatState(_type,_index);
}

class _ChatState extends State<Chat> {
  // FocusNode _focusNode = new FocusNode();
  ScrollController _sc;
  
  Constant constant = new Constant();
  int index,type;
  _ChatState(this.type,this.index);
  Conversation data;
  //聊天记录list
  List<Map<String, Object>> list = [];
  List _historyMessage = new List();
  @override
  void initState() {
    super.initState();
    _sc = new ScrollController();
  }

  void _sendMessage() {
    setState(() {
      var _message = constant.inputText;
      Provide.value<WebSocketProvide>(context).sendMessage(2, _message, data.userId);

      constant.inputText = "";
      _jumpBottom();
    });
  }

  void _jumpBottom() {
    //滚动到底部
    _sc.animateTo(9999, curve: Curves.easeOut, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    
    // 获取重新排序后的messageList
    int id = constant.orderMessage[index];
    Provide.value<WebSocketProvide>(context).messageList[id].unreadMsgCount = 0;
    data = Provide.value<WebSocketProvide>(context).messageList[id];
    return InheritedContext(
      data: data,
      doData: _sendMessage,
      child: Container(
        child: MaterialApp(
            home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                Navigator.pop(context);
                setState(() {
                  // Provide.value<WebSocketProvide>(context).historyMessage[index]['status'] = 0;
                });    
              },
            ),
            title: Text(data.title),
            actions: <Widget>[
              Container(
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
          body: Column(
            children: <Widget>[
              Provide<WebSocketProvide>(builder: (context, child, val) {              
                  list = [];
                  var historyMessage = Provide.value<WebSocketProvide>(context).historyMessage;
                  _historyMessage = historyMessage;
                  for (var i = 0; i < historyMessage.length; i++) {
                    if (data.userId != null) {
                      if (historyMessage[i]['bridge'].contains(data.userId)) {
                        if (historyMessage[i]['uid'] == data.userId) {
                          //重置未读信息的数量,status=0为已读,1为未读
                          Provide.value<WebSocketProvide>(context).historyMessage[i]['status'] = 0;
                          //对方
                          list.add(
                              {'type': 0, 'text': historyMessage[i]['msg'], 'nickname': historyMessage[i]['nickname']});                                                               
                        } else {
                          list.add(
                              {'type': 1, 'text': historyMessage[i]['msg'], 'nickname': historyMessage[i]['nickname']});
                        }                 
                      }
                    }
                    // }else if(data.groupId != null && data.groupId == historyMessage[i]['groupId'] && historyMessage[i]['bridge'].length==0){
                    //   var uid = Provide.value<WebSocketProvide>(context).uid;
                    //   if(historyMessage[i]['uid'] != uid ){
                    //     list.add({'type':0,'text':historyMessage[i]['msg'],'nickname':historyMessage[i]['nickname']});
                    //   }else{
                    //     list.add({'type':1,'text':historyMessage[i]['msg'],'nickname':historyMessage[i]['nickname']});
                    //   }
                    // }
                  }               
                return Flexible(
                  child: GestureDetector(
                    child: ListView.builder(
                      controller: _sc,
                      physics: ClampingScrollPhysics(),
                      // reverse: true,
                      itemBuilder: itemBuilder,
                      itemCount: list.length,
                    ),
                    //点击空白处失去焦点收回键盘
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() {});
                    },
                  ),
                );
              }),
              ChatInput(),
            ],
          ),
        )),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    bool position;
    String headIcon;
    bool timeFlag;
    Me me = new Me();    
    //判断是自己发送的消息还是对方来设置头像和内容位置
    if (list[index]["type"] == 1) {
      position = true;
      headIcon = me.avatar;
    } else {
      position = false;
      headIcon = data.avatar;
    }

    //判断是否显示时间
    if (index == 0) {
      timeFlag = true;
    } else if (Comparable.compare(_historyMessage[index]["time"].substring(11, 16), _historyMessage[index - 1]["time"].substring(11, 16)) !=0) {
      //如果和上一条消息分钟不相同，则显示
      timeFlag = true;
    } else {
      timeFlag = false;
    }
    _jumpBottom();
    return Container(
        child: Align(
      heightFactor: 1.1,
      child: (Column(
        children: <Widget>[
          timeFlag
              ? Text(
                  this._historyMessage[index]['time'].substring(11, 16),
                  style: TextStyle(fontSize: 13),
                )
              : Text(""),
          ListTile(
            //leading和training都进行了布局，通过position来判定是否展示
            leading: SizedBox(
              child: position
                  ? null
                  : CircleAvatar(
                      backgroundImage: AssetImage(headIcon),
                    ),
              width: 50.0,
              height: 50.0,
            ),
            trailing: SizedBox(
              child: position
                  ? CircleAvatar(
                      backgroundImage: AssetImage(headIcon),
                    )
                  : null,
              width: 50.0,
              height: 50.0,
            ),
            //通过position来判定title是居左还是居右
            title: position
                ? Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      list[index]["text"],
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      list[index]["text"],
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
          ),
        ],
      )),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _sc.dispose();
  }
}
