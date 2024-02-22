import 'package:animate_do/animate_do.dart';
import 'package:demo02_chat/res/styles.dart';
import 'package:demo02_chat/service/chat_input_box_service.dart';
import 'package:demo02_chat/widget/chat_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatInputBox extends StatefulWidget {
  const ChatInputBox({
    this.onSend,
    this.focusNode,
    this.controller,
    required this.toolbox,
    super.key,
  });

  final ValueChanged<String>? onSend;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Widget toolbox;

  @override
  State<ChatInputBox> createState() => _ChatInputBoxState();
}

class _ChatInputBoxState extends State<ChatInputBox> {
  bool _toolsVisible = false;
  bool _emojiVisible = false;
  bool _rightKeyboardButton = false;
  bool _sendButtonVisible = false;

  @override
  void initState() {
    // 监听输入框的焦点状态
    widget.focusNode?.addListener(() {
      // 如果当前输入框获得焦点
      if (widget.focusNode!.hasFocus) {
        setState(() {
          _toolsVisible = false;
          _emojiVisible = false;
          _rightKeyboardButton = false;
        });
      }
    });

    // 监听输入内容, 如果内容不为空的时候，则直接设置为
    widget.controller?.addListener(() {
      setState(() {
        _sendButtonVisible = widget.controller!.text.isNotEmpty;
      });
    });
    Get.find<ChatInputBoxService>().toolboxFlag.listen((v) {
      debugPrint("v ===> $v");
      if (!v) {
        toggleToolbox(closeFlag: true);
      }
    });
    super.initState();
  }

  focus() => FocusScope.of(context).requestFocus(widget.focusNode);

  unFocus() => FocusScope.of(context).requestFocus(FocusNode());

  Future<void> send() async {
    if (!_emojiVisible) {
      focus();
    }
    if (null != widget.onSend && null != widget.controller) {
      widget.onSend!(widget.controller!.text.toString().trim());
    }
  }

  Future<void> toggleToolbox({bool closeFlag = false}) async {
    setState(() {
      _toolsVisible = !_toolsVisible;
      _emojiVisible = false;
      _rightKeyboardButton = false;
      if (_toolsVisible) {
        unFocus();
        ChatInputBoxService.to.setToolBoxFlag(true);
      } else {
        ChatInputBoxService.to.setToolBoxFlag(false);
        if (!closeFlag) {
          focus();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 56.h),
          color: const Color(0xFFF0F2F6),
          child: _buildRowWidget(),
        ),
        Visibility(
          visible: _toolsVisible,
          child: FadeInUp(
            duration: const Duration(milliseconds: 50),
            child: widget.toolbox,
          ),
        ),
      ],
    );
  }

  _buildRowWidget() {
    return Row(
      children: [
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: Styles.c_FFFFFF,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: ChatTextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              style: Styles.ts_0C1C33_17sp,
              inputFormatters: const [],
              enabled: true,
              hintText: 'hintText',
              textAlign: TextAlign.start,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: _sendButtonVisible ? send : toggleToolbox,
          child: Image.asset(
            _sendButtonVisible
                ? 'assets/images/ic_send_message.webp'
                : 'assets/images/ic_open_toolbox.webp',
            width: 32.w,
            height: 32.h,
          ),
        ),
        SizedBox(width: 12.w),
      ],
    );
  }
}
