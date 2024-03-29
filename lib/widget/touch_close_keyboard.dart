import 'package:demo02_chat/res/styles.dart';
import 'package:flutter/material.dart';

class TouchCloseSoftKeyboard extends StatelessWidget {
  final Widget child;
  final Function? onTouch;
  // 是否是渐变背景
  final bool isGradientBg;

  const TouchCloseSoftKeyboard({
    Key? key,
    required this.child,
    this.onTouch,
    this.isGradientBg = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        onTouch?.call();
      },
      child: isGradientBg
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Styles.c_0089FF_opacity10,
                    Styles.c_FFFFFF_opacity0,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: child,
            )
          : child,
    );
  }
}
