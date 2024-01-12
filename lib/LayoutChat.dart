import 'package:flutter/cupertino.dart';

class LayoutChat extends StatefulWidget {
  const LayoutChat({super.key});

  @override
  LayoutChatState createState() => LayoutChatState();
}

class LayoutChatState extends State {


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Text('Hola joel'))
    ;
  }

}