/*
 * @Description: 聊天输入框状态管理
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-10 14:17:05
 * @LastEditTime: 2020-01-13 17:27:27
 * @LastEditors: leooooli
 * @LastEmail: gdutlikai@163.com
 */
import 'package:flutter/material.dart';
import 'package:qq/model/conversation.dart';

class InheritedContext extends InheritedWidget {
  
  //数据
  final Conversation data;

  final Function() doData;


  InheritedContext({
    Key key,
    @required this.data,
    @required this.doData,
    @required Widget child,
  }) : super(key: key, child: child);

  static InheritedContext of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: InheritedContext);
  }

  //是否重建widget就取决于数据是否相同
  @override
  bool updateShouldNotify(InheritedContext oldWidget) {
    return data != oldWidget.data;
  }
}