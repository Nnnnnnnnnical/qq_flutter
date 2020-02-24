/*
 * @Description: 用户信息
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-13 19:03:44
 * @LastEditTime: 2020-01-15 10:52:31
 * @LastEditors: leooooli
 * @LastEmail: gdutlikai@163.com
 */

class Me {

  String name;
  String avatar;
  String account;

  factory Me() =>_getInstance();
  static Me get instance => _getInstance();
  static Me _instance;
  
  Me._internal() {

  }

  static Me _getInstance() {
    if (_instance == null) {
      _instance = new Me._internal();
    }
    return _instance;
  }
}

