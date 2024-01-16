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

  const MessageCard({super.key, required this.messageIndex});

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);
    bool isAi =
        appData.messageList[widget.messageIndex].author == ai ? true : false;
    String messageText = appData.messageList[widget.messageIndex].messageText;
    double width = MediaQuery.of(context).size.width;
    double constraint = (messageText.length * 10).clamp(50, 500).toDouble();
    
    print("--------------------------");
    print(width);
    print(constraint);

    return Card(
      elevation: 10,
      color: CDKTheme.white,
      margin: EdgeInsets.fromLTRB(isAi ? 15 : (500 - constraint) + 150 , 10, isAi ? (500 - constraint) + 150 : 15, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: CDKTheme.grey80,
          width: 1.0,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Row(
          children: [
            Expanded(
              child: Container(
                // Right side content
                alignment: Alignment.centerLeft,
                child:
                    Text(appData.messageList[widget.messageIndex].messageText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
