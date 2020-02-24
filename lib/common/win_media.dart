/*
 * @Description: 
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-06 20:13:45
 * @LastEditTime: 2020-01-07 11:23:30
 * @LastEditors: leooooli
 * @LastEmail: gdutlikai@163.com
 */


import 'dart:ui';

import 'package:flutter/material.dart';

double winWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double winHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double winTop(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

double winBottom(BuildContext context) {
  return MediaQuery.of(context).padding.bottom;
}

double winLeft(BuildContext context) {
  return MediaQuery.of(context).padding.left;
}

double winRight(BuildContext context) {
  return MediaQuery.of(context).padding.right;
}

double winKeyHeight(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom;
}

double statusBarHeight(BuildContext context) {
  return MediaQueryData.fromWindow(window).padding.top;
}

double navigationBarHeight(BuildContext context) {
  return kToolbarHeight;
}

double topBarHeight(BuildContext context) {
  return kToolbarHeight + MediaQueryData.fromWindow(window).padding.top;
}
