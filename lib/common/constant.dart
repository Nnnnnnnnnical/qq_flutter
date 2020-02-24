/*
 * @Description: 常用类
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-09 17:42:30
 * @LastEditTime : 2020-01-20 16:37:35
 * @LastEditors  : Please set LastEditors
 * @LastEmail: gdutlikai@163.com
 */
class Constant{

  factory Constant() =>_getInstance();
  static Constant get instance => _getInstance();
  static Constant _instance;
  Constant._internal() {
    // 初始化
  }

  static Constant _getInstance() {
    if (_instance == null) {
      _instance = new Constant._internal();
    }
    return _instance;
  }

  //聊天输入框
  String inputText = "";

  //新旧消息列表顺序
  List orderMessage = [];

  //消息列表的数据
  List messageList = [];

}