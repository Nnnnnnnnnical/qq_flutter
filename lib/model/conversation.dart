/*
 * @Description: 对话的实体类
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-10 18:56:56
 * @LastEditTime : 2020-01-20 15:51:24
 * @LastEditors  : Please set LastEditors
 * @LastEmail: gdutlikai@163.com
 */

class Conversation {
  int id; //唯一标识符
  String avatar; //头像
  String title; //名称
  int titleColor; //颜色
  String des; //描述
  String updateAt; //时间
  bool isMute; // 是否静音
  int unreadMsgCount; //未读消息数量
  bool displayDot; //是否展示
  int groupId; //小组id
  String userId; //用户id
  int type; //类型 1是获取消息 2是发送消息
  
  bool isAvatarFromNet() {
    if(this.avatar.indexOf('http') == 0 || this.avatar.indexOf('https') == 0) {
      return true;
    }
    return false;
  }

  Conversation({
    this.id,
    this.avatar,
    this.title,
    this.titleColor : 0xff353535,
    this.des,
    this.updateAt,
    this.isMute : false,
    this.unreadMsgCount : 0,
    this.displayDot : false,
    this.groupId,
    this.userId,
    this.type
  });

  @override
  String toString() {
    // TODO: implement toString
    return "userId : ${userId}";
  }
}