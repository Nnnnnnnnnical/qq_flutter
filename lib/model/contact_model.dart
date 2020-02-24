/*
 * @Description: 
 * @Author: FlutterCandies
 * @email: 
 * @Date: 2020-01-06 16:23:15
 * @LastEditTime : 2020-01-19 15:55:05
 * @LastEditors  : Please set LastEditors
 * @LastEmail: gdutlikai@163.com
 */

import 'package:azlistview/azlistview.dart';

class ContactInfo extends ISuspensionBean {
  
  int id; //唯一标实
  String userId; //用户id
  String name; //名称
  String tagIndex; //tag的索引
  String namePinyin; //中文名拼音
  String avatar; //头像

  ContactInfo({
    this.id,
    this.userId,
    this.name,
    this.tagIndex,
    this.namePinyin,
    this.avatar,
  });

  ContactInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'tagIndex': tagIndex,
        'namePinyin': namePinyin,
        'isShowSuspension': isShowSuspension,
        'avatar': avatar,
      };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => "Contact_model {" + " \"name\":\"" + name + "\"" + " \"userId\":\"" + userId + "\"" + '}';
}
