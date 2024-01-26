import 'package:flutter/cupertino.dart';

class Message {
  final int _messageId; // Enter final que representa l'id del missatge
  int author; // Enter que representa qui ha enviat el missatge (IA o usuari)
  String messageText; // Cadena de text que representa el contingut del missatge
  Image? image; // Imatge que ve adjunta amb el missatge (en cas de fer servir Llava)

  Message(this._messageId, this.messageText, this.author, this.image);

  int get messageId => _messageId;
}
