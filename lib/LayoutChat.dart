import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutChat extends StatefulWidget {
  const LayoutChat({super.key});

  @override
  LayoutChatState createState() => LayoutChatState();
}

class LayoutChatState extends State<LayoutChat> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('WIP'),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white54,
              width: MediaQuery.of(context).size.width > MediaQuery.of(context).size.width
                  ? MediaQuery.of(context).size.width * 0.9
                  : MediaQuery.of(context).size.height * 0.8,
              height: MediaQuery.of(context).size.height,
            ),
          ],
        ),
      ),
    );
  }
}
