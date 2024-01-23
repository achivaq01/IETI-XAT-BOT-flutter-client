import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
    FilePicker filePicker = FilePicker.platform;
    double chatContainerWidth =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width * 0.8
            : MediaQuery.of(context).size.height * 0.8;
    double chatContainerHeight = MediaQuery.of(context).size.height * 0.95;
    double textInputWidth =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width * 0.65
            : MediaQuery.of(context).size.height * 0.65;
    double textInputHeight =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width * 0.05
            : MediaQuery.of(context).size.height * 0.05;
    double textSize =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width * 0.02
            : MediaQuery.of(context).size.height * 0.02;
    double buttonSize =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width * 0.05
            : MediaQuery.of(context).size.height * 0.05;
    bool attachedButtonDisabled = false;
    Image? image;

    if (appData.attachedImage == null) {
      image = null;
    } else {
      image = Image.file(appData.attachedImage!.file);
    }

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
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Container(
                            color: Colors.white54,
                            width: chatContainerWidth,
                            height: chatContainerHeight,
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
                          Positioned(
                            height: MediaQuery.of(context).size.height * 1.8,
                            left: chatContainerWidth * 0.78,
                            child: Visibility(
                              visible: image != null,
                              child: SizedBox.fromSize(
                                size: Size(
                                    MediaQuery.of(context).size.width * 0.1,
                                    MediaQuery.of(context).size.width * 0.1),
                                child: image
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: textInputWidth,
                            height: textInputHeight,
                            child: CDKFieldText(
                              controller: textController,
                              placeholder: 'Ask something!',
                              textSize: textSize,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          SizedBox(
                            width: buttonSize,
                            height: buttonSize,
                            child: CupertinoButton(
                                onPressed: () async {
                                  FilePickerResult? pickedFile =
                                      await filePicker.pickFiles();
                                  appData.setAttachedImage(pickedFile!);
                                  //appData.sendMessage(text);
                                },
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(5),
                                child: Tooltip(
                                  message: "Attach image",
                                  child: Icon(
                                    CupertinoIcons.photo,
                                    size: buttonSize * 0.5,
                                    color: CDKTheme.white,
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: buttonSize,
                            height: buttonSize,
                            child: CupertinoButton(
                              onPressed: () async {
                                if (!attachedButtonDisabled) {
                                  appData.attachedImage = null;
                                  attachedButtonDisabled = true;
                                  appData.forceNotifyListeners();
                                }
                              },
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(5),
                              child: Tooltip(
                                message: "Detach",
                                child: Icon(
                                  CupertinoIcons.pin_slash_fill,
                                  size: buttonSize * 0.5,
                                  color: CDKTheme.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: buttonSize,
                            height: buttonSize,
                            child: CupertinoButton(
                              onPressed: () async {
                                if (appData.isResponding) {
                                  await appData.sendStopRequest("http://localhost:3000/data");
                                  appData.isResponding = false;
                                  appData.forceNotifyListeners();
                                } else {
                                  String text = textController.text;
                                  await appData.sendMessage(text);
                                }
                                //scrollDown();
                              },
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(5),
                              child: Tooltip(
                                message: appData.isResponding ? "Stop" : "Send",
                                child: Icon(
                                  appData.isResponding ? CupertinoIcons.square_fill : CupertinoIcons.paperplane_fill,
                                  size: buttonSize * 0.5,
                                  color: CDKTheme.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ],
    ));
  }
}
