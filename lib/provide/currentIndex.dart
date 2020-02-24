/*
 * @Description: 
 * @Author: leooooli
 * @email: gdutlikai@163.com
 * @Date: 2020-01-10 18:57:13
 * @LastEditTime: 2020-01-13 17:23:51
 * @LastEditors: leooooli
 * @LastEmail: gdutlikai@163.com
 */
import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier{
  int currentIndex = 0;

  changeIndex(int newIndex){
    currentIndex = newIndex;
    notifyListeners();
  }
}