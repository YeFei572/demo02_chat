import 'package:demo02_chat/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatToolBox extends StatelessWidget {
  const ChatToolBox({
    this.onTapAlbum,
    this.onTapCall,
    this.onTapCamera,
    this.onTapCard,
    this.onTapFile,
    this.onTapLocation,
    super.key,
  });

  final Function()? onTapAlbum;
  final Function()? onTapCamera;
  final Function()? onTapCall;
  final Function()? onTapFile;
  final Function()? onTapCard;
  final Function()? onTapLocation;

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Styles.c_F0F2F6,
      height: 224.h,
      width: double.infinity,
    );
  }
}
