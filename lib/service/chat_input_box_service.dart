import 'package:get/get.dart';

class ChatInputBoxService extends GetxService {
  // bool toolsVisible = false;
  // bool emojiVisible = false;
  // bool rightKeyboardButton = false;
  // bool sendButtonVisible = false;
  RxBool toolboxFlag = false.obs;

  static get to => Get.find<ChatInputBoxService>();

  setToolBoxFlag(bool flag) {
    if (flag != toolboxFlag.value) {
      toolboxFlag.value = flag;
    }
  }

}
