import 'package:demo02_chat/page/chat/chat_binding.dart';
import 'package:demo02_chat/page/chat/chat_page.dart';
import 'package:demo02_chat/page/home/home_page.dart';
import 'package:demo02_chat/route/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    )
  ];
}
