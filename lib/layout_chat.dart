import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_desktop_kit/cdk.dart';
import 'package:flutter_postget/util_message_widget.dart';
import 'package:provider/provider.dart';

import 'app_data.dart';

class LayoutChat extends StatefulWidget {
  const LayoutChat({super.key});

  @override
  LayoutChatState createState() => LayoutChatState();
}

class LayoutChatState extends State<LayoutChat> {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);
    TextEditingController textController = TextEditingController();
    ScrollController scrollController = ScrollController();

    void scrollDown() {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }

    return CupertinoPageScaffold(
        child: Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white54,
                  width: MediaQuery.of(context).size.width >
                          MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.width * 0.9
                      : MediaQuery.of(context).size.height * 0.8,
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: ListView.builder(
                    itemCount: appData.messageList.length,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      scrollDown();
                      return MessageCard(
                        messageIndex: index,
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width >
                              MediaQuery.of(context).size.width
                          ? MediaQuery.of(context).size.width * 0.75
                          : MediaQuery.of(context).size.height * 0.75,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CDKFieldText(
                        controller: textController,
                        placeholder: 'Ask something!',
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width >
                              MediaQuery.of(context).size.width
                          ? MediaQuery.of(context).size.width * 0.05
                          : MediaQuery.of(context).size.height * 0.05,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CupertinoButton(
                        onPressed: () {
                          String text = textController.text;
                          appData.sendMessage(text);
                        },
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          CupertinoIcons.paperplane_fill,
                          size: 20,
                          color: CDKTheme.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
