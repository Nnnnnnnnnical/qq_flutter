/*
 * @Description: 联系人界面UI
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-03 21:49:20
 * @LastEditTime : 2020-01-20 16:48:48
 * @LastEditors  : Please set LastEditors
 * @LastEmail: gdutlikai@163.com
 */

import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:provide/provide.dart';
import 'package:qq/model/contact_model.dart';
import 'package:qq/pages/chat.dart';
import 'package:qq/provide/websocket.dart';

class ContactUi extends StatefulWidget {
  ContactUi({Key key}) : super(key: key);

  @override
  _ContactUiState createState() => _ContactUiState();
}

class _ContactUiState extends State<ContactUi> {
  List<ContactInfo> _contacts = List();
  List _messageList = List();
  int _suspensionHeight = 40;
  int _itemHeight = 60;

  @override
  void initState() {
    super.initState();
  }

  void _handleList(List<ContactInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      list[i].id = i;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_contacts);
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: _suspensionHeight.toDouble(),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Text(
            '$susTag',
            textScaleFactor: 1.2,
          ),
          Expanded(
              child: Divider(
            height: .0,
            indent: 10.0,
          ))
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, ContactInfo model) {
    BuildContext parentContext = context;
    String susTag = model.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
            leading: SizedBox(
              child: CircleAvatar(
                backgroundImage: AssetImage(model.avatar),
              ),
              width: 50.0,
              height: 50.0,
            ),
            title: Text(model.name),
            onTap: () {
              print("OnItemClick: $model");
              Navigator.of(parentContext)
                  .push(new MaterialPageRoute(builder: (context) {
                return Chat(1,model.id);
              }));
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provide<WebSocketProvide>(builder: (context, child, val) {
      var messageList = Provide.value<WebSocketProvide>(context).messageList;
      if (_messageList.length != messageList.length) {
        //初始化contact
        if (_messageList.length == 0) {
          messageList.forEach((value) {
            _contacts.add(ContactInfo(
                name: value.title, avatar: value.avatar, userId: value.userId));
          });
        }else{
          //添加好友新增contact，就把新增的messageList最后一条新增
          var temp = messageList[messageList.length-1];
          _contacts.add(ContactInfo(
                name: temp.title, avatar: temp.avatar, userId: temp.userId));
        }

        _messageList = messageList;
      }
      //处理list
      _handleList(_contacts);
      return new Expanded(
          child: AzListView(
        data: _contacts,
        itemBuilder: (context, model) => _buildListItem(context, model),
        isUseRealIndex: true,
        itemHeight: _itemHeight,
        suspensionHeight: _suspensionHeight,
        indexBarBuilder: (BuildContext context, List<String> tags,
            IndexBarTouchCallback onTouch) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            decoration: BoxDecoration(
                color: Colors.grey[50]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: IndexBar(
                data: tags,
                itemHeight: 20,
                onTouch: (details) {
                  onTouch(details);
                },
              ),
            ),
          );
        },
        indexHintBuilder: (context, hint) {
          return Container(
            alignment: Alignment.center,
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.blue[700].withAlpha(200),
              shape: BoxShape.circle,
            ),
            child: Text(hint,
                style: TextStyle(color: Colors.white, fontSize: 30.0)),
          );
        },
      ));
    });
  }
}
