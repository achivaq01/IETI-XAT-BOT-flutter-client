import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_desktop_kit/cdk.dart';
import 'package:provider/provider.dart';

import 'app_data.dart';

enum MessageAlignment {
  left,
  right,
}

class MessageCard extends StatefulWidget {
  final int messageIndex;

  const MessageCard({Key? key, required this.messageIndex}) : super(key: key);

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);
    double textSize = MediaQuery.of(context).size.width * 0.01;
    double maxContainerLength = MediaQuery.of(context).size.width * 0.3;
    bool isAi = appData.messageList[widget.messageIndex].author == ai;
    String messageText = appData.messageList[widget.messageIndex].messageText;

    double constraint =
    (messageText.length * textSize) > maxContainerLength
        ? maxContainerLength
        : (messageText.length * textSize) + 30;

    return Align(
      alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: Card(
        elevation: 10,
        color: CDKTheme.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(
            color: CDKTheme.grey80,
            width: 1.0,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          constraints: BoxConstraints(maxWidth: constraint),
          child: Text(
            messageText,
            style: TextStyle(fontSize: textSize),
          ),
        ),
      ),
    );
  }
}
