/*
 * @Description: 聊天输入框UI
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-07 17:04:52
 * @LastEditTime : 2020-02-13 20:41:47
 * @LastEditors  : Please set LastEditors
 * @LastEmail: gdutlikai@163.com
 */
import 'package:flutter/material.dart';
import 'package:qq/common/constant.dart';
import 'package:qq/provide/inherited_chat_input.dart';

class ChatInput extends StatefulWidget {

  ChatInput();
  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {

  Constant constant = new Constant();

  @override
  Widget build(BuildContext context) {
    final inheritedContext = InheritedContext.of(context);
    TextEditingController _textController = new TextEditingController();

    return Container(
      child: (GestureDetector(
        child: Container(
          height: 120.0,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.only(top: 7.0, bottom: 7.0, left: 4.0, right: 8.0),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        controller: _textController,
                        maxLines: 99,
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0)),
                      ),
                    ),
                  ),
                  InkWell(
                      child: IconButton(
                        icon: Icon(Icons.send),
                        color: Colors.blue,
                        onPressed: (){
                          constant.inputText = _textController.text;
                          inheritedContext.doData();                   
                        }
                  )),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50,
                      
                      child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Image.asset("images/picture.png",fit: BoxFit.cover),
                              Image.asset("images/emoji.png",fit: BoxFit.cover),
                              Image.asset("images/video.png",fit: BoxFit.cover),
                              Image.asset("images/dress.png",fit: BoxFit.cover),
                              Image.asset("images/date.png",fit: BoxFit.cover),
                              Image.asset("images/more.png",fit: BoxFit.cover),
                              
                            ],
                          ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        onTap: () {
          
        },
      )),
    );
  }
}
