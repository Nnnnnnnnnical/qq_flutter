/*
 * @Description: 搜索内容UI
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-03 11:20:22
 * @LastEditTime: 2020-01-13 17:29:09
 * @LastEditors: leooooli
 * @LastEmail: gdutlikai@163.com
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchContent extends StatefulWidget {
  SearchContent({Key key}) : super(key: key);

  @override
  _SearchContentState createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(15),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5.0),
            prefixIcon: Icon(Icons.search),
            
            hintText: "请输入搜索内容",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            // filled: true,
            fillColor: Color.fromRGBO(221, 221, 221, 0.5),
          ),
        ),
      ),
    );
  }
}
 