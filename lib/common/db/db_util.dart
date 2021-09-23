import 'dart:io';

import 'package:fmm_app/common/db/index.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:fmm_app/global.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DBUtil {
  /// 实例
  static DBUtil? instance;

  /// 用户信息
  late Box<User> userBox;

  /// 初始化，需要在 main.dart 调用
  /// <https://docs.hivedb.dev/>
  static Future<void> install() async {
    /// 初始化数据库地址
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);

    /// 注册自定义对象（实体）
    /// <https://docs.hivedb.dev/#/custom-objects/type_adapters>
    /// Hive.registerAdapter(SettingsAdapter());
    Hive.registerAdapter(UserAdapter());

  }

  /// 初始化 Box
  static Future<DBUtil> getInstance() async {
    if (instance == null) {
      instance = DBUtil();
      // await Hive.initFlutter();
      //
      instance?.userBox = await Hive.openBox('user');
    }
    return instance!;
  }

  /// 获取当前用户
  User? getUser(){
    final users = Global.dbUtil.userBox.values;
    users.forEach((element) {
      Logger.ggq('----user---->>${element.userId}');
    });
    if(users.isNotEmpty) {
      return users.last;
    }
    return null;
  }

  /// 保存用户
  Future<int> saveUser (User user) async{
    return await Global.dbUtil.userBox.add(user);
  }

  /// 跟新用户信息
  void updateUser (User user) {
    final users = Global.dbUtil.userBox.values;
    if(users.isNotEmpty) {
      Global.dbUtil.userBox.putAt(users.length, user);
    }
  }
  
  /// 清除用户
  Future<int> clearUser() async{
    return await Global.dbUtil.userBox.clear();
  }

  /// 用户是否登录
  bool isLogin () {
    return Global.dbUtil.getUser() != null;
  }

}