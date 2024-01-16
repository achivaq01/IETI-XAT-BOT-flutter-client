import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_postget/util_message.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

const int ai = 0;
const int user = 1;

class AppData with ChangeNotifier{
  List<Message> messageList = [];
  int newMessageId = 0;
  dynamic dataPost;

  void sendMessage(String text) async {
    late Message newMessage;
    if (text.startsWith('!')) {
      newMessage = Message(newMessageId, text, ai);
    } else {
      newMessage = Message(newMessageId, text, user);
    }
    messageList.add(newMessage);
    newMessageId++;

    loadHttpPostByChunks("http://localhost:3000/data", text);

    notifyListeners();
  }

  void addMessageToList(Message message) {

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