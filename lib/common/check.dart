/*
 * @Description: 鉴别信息的方法库
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-06 20:14:52
 * @LastEditTime: 2020-01-13 17:21:31
 * @LastEditors: leooooli
 * @LastEmail: gdutlikai@163.com
 */


/// 字符串不为空
bool strNoEmpty(String value) {
  if (value == null) return false;

  return value.trim().isNotEmpty;
}