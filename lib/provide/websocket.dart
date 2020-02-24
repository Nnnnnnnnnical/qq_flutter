/*
 * @Description: socket链接类方法
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-10 18:57:17
 * @LastEditTime : 2020-02-12 11:43:50
 * @LastEditors  : Please set LastEditors
 * @LastEmail: gdutlikai@163.com
 */
import 'dart:convert';
import 'dart:math';
import 'package:date_format/date_format.dart';
import 'package:qq/common/constant.dart';
import 'package:qq/model/conversation.dart';
import 'package:qq/model/me.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';

class WebSocketProvide with ChangeNotifier {
  
  var uid = '';
  var nickname = '';
  var avatar = '';
  var users = [];
  var groups = [];
  var historyMessage = []; //接收到哦的所有的历史消息
  var messageList = []; // 所有消息页面人员
  var currentMessageList = []; //选择进入详情页的消息历史记录
  var connecting = false; //websocket连接状态
  IOWebSocketChannel channel;
  Me me =  Me();

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userInfo = prefs.getString('userInfo');
    // 清空本地数据
    // prefs.remove('userInfo');
    print("userInfo:${userInfo}");
    if (userInfo == null) {
      var now = new DateTime.now();
      nickname = "qq_${Random().nextInt(100)}";
      avatar = "images/${Random().nextInt(10)+11}.png";
      uid = "qq_${now.microsecondsSinceEpoch}";
      //弹出设置用户名
      var data = {
        "nickname": nickname,
        "avatar": avatar,
        "uid": uid,
      };
      
      var userInfoStr = json.encode(data).toString();
      prefs.setString('userInfo', userInfoStr);
    } else {
      var userInfoData = json.decode(userInfo.toString());
      // print("userINfoData:${userInfoData}");
      uid = userInfoData['uid'];
      nickname = userInfoData['nickname'];
      avatar = userInfoData['avatar'];
    }
    
    me.account = uid;
    me.name = nickname;
    me.avatar = avatar;
    return await createWebsocket();
  }

  createWebsocket() async {
    //创建连接并且发送鉴别身份信息
    channel = await new IOWebSocketChannel.connect('ws://localhost:3001');
    var obj = {
      "uid": uid,
      "type": 1,
      "nickname": nickname,
      "msg": "",
      "bridge": [],
      "avatar": avatar,
      "time": "",
      // "groupId": ""
    };
    String text = json.encode(obj).toString();
    channel.sink.add(text);
    //监听到服务器返回消息
    channel.stream.listen((data) => listenMessage(data), onError: onError, onDone: onDone);
  }

  listenMessage(data) {
    connecting = true;
    var obj = jsonDecode(data);
    // print(data);
    if (obj['type'] == 1) {
      // 获取聊天室的人员与群列表
      messageList = [];
      // print(obj['msg']);
      users = obj['users'];
      groups = obj['groups'];
      // for(var i = 0; i < groups.length; i++){
      //   messageList.add(new Conversation(
      //     avatar: 'assets/images/ic_group_chat.png',
      //     title: groups[i]['name'],
      //     des: '点击进入聊天',
      //     updateAt: obj['date'].substring(11,16),
      //     unreadMsgCount: 0,
      //     displayDot: false,
      //     groupId: groups[i]['id'],
      //     type: 2
      //   ));
      // }
      var id = 0;
      for (var i = 0; i < users.length; i++) {
        if (users[i]['uid'] != uid) {
          messageList.add(new Conversation(
              id: id++,
              avatar: users[i]['avatar'],
              title: users[i]['nickname'],
              des: " ",
              updateAt: obj['time'],
              unreadMsgCount: 0,
              displayDot: false,
              userId: users[i]['uid'],
              type: 1));
        }
      }
    } else if (obj['type'] == 2) {
      //接收到消息
      historyMessage.add(obj);
      // print("接受消息");
      // print(historyMessage);
      for (var i = 0; i < messageList.length; i++) {
        if (messageList[i].userId != null) {
          var count = 0;
          for (var r = 0; r < historyMessage.length; r++) {
            if (historyMessage[r]['status'] == 1 &&
                historyMessage[r]['bridge'].contains(messageList[i].userId) &&
                historyMessage[r]['uid'] != uid) {
              count++;
            }
          }
          // messageList[i].displayDot = true;
          messageList[i].unreadMsgCount = count;          
          
        }
        // print("obj:${obj}");
        //如果发送的消息里包含当前messageList的user，就将subTitle和时间重新赋值
        if(obj["bridge"].contains(messageList[i].userId)){
          messageList[i].des = obj["msg"];
          messageList[i].updateAt = obj['time'];
        }
        // if (messageList[i].groupId != null) {
        //   var count = 0;
        //   for (var r = 0; r < historyMessage.length; r++) {
        //     if (historyMessage[r]['status'] == 1 &&
        //         historyMessage[r]['groupId'] == messageList[i].groupId &&
        //         historyMessage[r]['uid'] != uid) {
        //       count++;
        //     }
        //   }
        //   if (count > 0) {
        //     messageList[i].displayDot = true;
        //     messageList[i].unreadMsgCount = count;
        //   }
        // }
      }
    }
    notifyListeners();
  }

  //拖拽小红点清空未读消息
  clearMessage(index){
    messageList[index].unreadMsgCount = 0;
    notifyListeners();
  }

  sendMessage(type, data, userId) {
    //发送消息

    var _bridge = [];
    if (userId != null) {
      _bridge..add(userId)..add(uid);
    }
    int _groupId;
    // if (messageList[index].groupId != null) {
    //   _groupId = messageList[index].groupId;
    // }
    // print("_bridge:${_bridge}");
    //分钟是用nn！！！ 不是mm。
    var time = formatDate(DateTime.now() ,[yyyy,'-',mm,'-',dd,' ',HH,':',nn,':',ss]);
    var obj = {"uid": uid, "type": 2, "nickname": nickname, "msg": data, "bridge": _bridge, "groupId": _groupId, "time":time};
    String text = json.encode(obj).toString();
    channel.sink.add(text);
  }

  onError(error) {
    print('error------------>${error}');
  }

  void onDone() {
    print('websocket断开了');
    createWebsocket();
    print('websocket重连');
  }

  closeWebSocket() {
    //关闭链接
    channel.sink.close();
    print('关闭了websocket');
    notifyListeners();
  }
}