import 'package:flutter/cupertino.dart';

class Message {
  final int _messageId;
  int author;
  String messageText;
  Image? image;

  Message(this._messageId, this.messageText, this.author, this.image);

  int get messageId => _messageId;
}