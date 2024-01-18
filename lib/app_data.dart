import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_postget/util_message.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

const int ai = 0;
const int user = 1;

class AppData with ChangeNotifier{
  List<Message> messageList = [];
  int newMessageId = 0;
  Image? attachedImage;
  dynamic dataPost;

  Future<void> sendMessage(String text) async {
    late Message newMessage;
    if (text.startsWith('!')) {
      newMessage = Message(newMessageId, text, ai);
    } else {
      newMessage = Message(newMessageId, text, user);
    }
    messageList.add(newMessage);
    newMessageId++;

    await loadHttpPostByChunks("http://localhost:3000/data", text);
    notifyListeners();
  }

  void scrollDown(ScrollController controller) {
    controller.jumpTo(controller.position.maxScrollExtent);
  }

  void setAttachedImage(FilePickerResult fileSelected) {
    if (!fileSelected.isSinglePick) {
      return;
    }
    if (fileSelected.files[0].extension != 'jpg' ) {
      return;
    }

    attachedImage = Image.file(File(fileSelected.files[0].path!));
    print(attachedImage.toString());
    notifyListeners();
  }

  void forceNotifyListeners() {
    notifyListeners();
  }

  Future<String> loadHttpPostByChunks(String url, String message) async {
    String key = "message";
    Map<String, dynamic> myMap = {
      key: message,
    };
    String body = jsonEncode(myMap);
    var request = http.post(
        Uri.parse(url),
        body: body,
        headers: {
          'Content-Type': 'application/json',
        },
    );

    var response = await request;

    return response.toString();
  }
}