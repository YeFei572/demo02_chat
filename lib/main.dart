import 'dart:io';

import 'package:demo02_chat/page/home/home_page.dart';
import 'package:demo02_chat/route/app_pages.dart';
import 'package:demo02_chat/route/app_routes.dart';
import 'package:demo02_chat/service/chat_input_box_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  /// 沉浸式状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  } else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }
  Get.put(ChatInputBoxService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 779),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: '聊天',
        getPages: AppPages.list,
        initialRoute: AppRoutes.home,
        home: const HomePage(),
      ),
    );
  }
}
