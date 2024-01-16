class Message {
  final int _messageId;
  int author;
  String messageText;

  Message(this._messageId, this.messageText, this.author);

  int get messageId => _messageId;
}