import 'package:demo02_chat/model/message.dart';
import 'package:demo02_chat/page/chat/chat_controller.dart';
import 'package:demo02_chat/res/styles.dart';
import 'package:demo02_chat/widget/chat_input_box.dart';
import 'package:demo02_chat/widget/chat_list_view.dart';
import 'package:demo02_chat/widget/chat_tool_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ChatController>(
      builder: (ctrl) => Scaffold(
        appBar: AppBar(
          title: const Text('消息测试'),
          actions: [
            IconButton(
              onPressed: ctrl.addRandomMessage,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatListView(
                itemCount: ctrl.messageList.length,
                controller: ctrl.scrollController,
                onScrollToBottomLoad: ctrl.onScrollToBottomLoad,
                onScrollToTop: ctrl.onScrollToTop,
                onTouch: ctrl.closeToolBox,
                itemBuilder: (_, int index) {
                  final res = ctrl.messageList.value.reversed.toList();
                  return _buildItemView(res[index]);
                },
              ),
            ),
            ChatInputBox(
              focusNode: ctrl.focusNode,
              controller: ctrl.controller,
              onSend: ctrl.onSend,
              toolbox: const ChatToolBox(),
            ),
          ],
        ),
      ),
    );
  }

  _buildItemView(Message message) {
    return Row(children: [
      Visibility(
        visible: message.userId == '0',
        child: const Spacer(),
      ),
      Container(
        margin: EdgeInsets.all(7.w),
        padding: EdgeInsets.all(10.w),
        constraints: BoxConstraints(
          maxWidth: ScreenUtil().screenWidth * .8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          color: message.userId == '0' ? Styles.c_F0F2F6 : Styles.c_92B3E0,
        ),
        child: Text(message.content ?? ''),
      ),
      Visibility(
        visible: message.userId == '1',
        child: const Spacer(),
      ),
    ]);
  }
}
