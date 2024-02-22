import 'dart:math';

import 'package:demo02_chat/model/message.dart';
import 'package:demo02_chat/service/chat_input_box_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxBool toolboxFlag = false.obs;
  RxList<Message> messageList = <Message>[].obs;

  // 输入框的焦点控制器
  final focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> onSend(String content) async {
    final m = Message()
      ..userId = messageList.length % 2 == 0 ? '0' : '1'
      ..content = content
      ..createTime = '';
    controller.clear();
    messageList.value = [...messageList.value, m];
  }

  closeToolBox() {
    debugPrint("======");
    ChatInputBoxService.to.setToolBoxFlag(false);
  }

  addRandomMessage() {
    int i = Random().nextInt(1000);
    onSend(i.toString());
  }

  Message indexOfMessage(int index, {bool calculate = true}) =>
      messageList.value.reversed.elementAt(index);

  Future<bool> onScrollToBottomLoad() async {
    return false;
  }

  void onScrollToTop() {

  }
}
