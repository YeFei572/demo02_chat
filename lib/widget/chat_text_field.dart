import 'package:demo02_chat/res/styles.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final TextAlign textAlign;

  const ChatTextField({
    this.focusNode,
    this.controller,
    this.hintText,
    this.style,
    this.inputFormatters,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExtendedTextField(
      style: style,
      focusNode: focusNode,
      controller: controller,
      keyboardType: TextInputType.multiline,
      enabled: enabled,
      autofocus: false,
      minLines: 1,
      maxLines: 4,
      textAlign: textAlign,
      decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        hintText: hintText,
        hintStyle: Styles.ts_8E9AB0_17sp,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 8.h,
        ),
      ),
      inputFormatters: inputFormatters,
    );
  }
}
