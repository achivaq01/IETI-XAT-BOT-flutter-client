import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_postget/util_message.dart';

const int ai = 0;
const int user = 1;

class AppData with ChangeNotifier{
  List<Message> messageList = [];
  int newMessageId = 0;
  FileImage? attachedImage = null;
  dynamic dataPost;
  bool isResponding = false;

  Future<void> sendMessage(String text) async {
    late Message newMessage;
    if (text.isEmpty) {
      return;
    }
    if (attachedImage == null) {
      newMessage = Message(newMessageId, text, user, null);
    } else {
      newMessage = Message(newMessageId, text, user, Image.file(attachedImage!.file));
    }

    messageList.add(newMessage);
    newMessageId++;
    notifyListeners();

    try {
      loadHttpPostByChunks("http://localhost:3000/data", text, messageList.length);
      Message aiResponseMessage = Message(newMessageId, "", ai, null);
      messageList.add(aiResponseMessage);
      newMessageId++;
    } catch (e) {
      print('no server response');
    }
    if (attachedImage != null) {
      attachedImage = null;
    }

    notifyListeners();
  }

  void scrollDown(ScrollController controller) {
    //controller.jumpTo(controller.position.maxScrollExtent);
  }

  void setAttachedImage(FilePickerResult fileSelected) {
    if (!fileSelected.isSinglePick) {
      return;
    }
    if (fileSelected.files[0].extension != 'jpg' ) {
      return;
    }

    attachedImage = FileImage(File(fileSelected.files[0].path!));
    print(attachedImage.toString());
    notifyListeners();
  }

  void forceNotifyListeners() {
    notifyListeners();
  }

  Future<void> loadHttpPostByChunks(String url, String message, int messageId) async {
    Map<String, dynamic> json;

    if (attachedImage != null) {
      FileImage resizedImage = attachedImage!;
      json = {
        'type': 'image',
        'message': message,
        'image': base64Encode(attachedImage!.file.readAsBytesSync()),
      };
    } else {
      json = {
        'type': 'text',
        'message': message,
        'image': null,
      };
    }
    String body = jsonEncode(json);

    // Use HttpClient for more control over the request
    var httpClient = HttpClient();
    var request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('Content-Type', 'application/json');
    request.write(body);
    isResponding = true;

    // Send the request
    var response = await request.close();

    // Use a Completer to handle the asynchronous nature of the response
    Completer<String> completer = Completer<String>();
    StringBuffer responseBuffer = StringBuffer();

    // Read the response in chunks
    response.transform(utf8.decoder).listen(
          (String chunk) {
        responseBuffer.write(chunk);
        if (!isResponding) {
          request.abort();
          completer.complete("cancelled");
          isResponding = true;
          return;
        }

        try {
          var jsonData = jsonDecode(responseBuffer.toString());
          print('Received JSON: $jsonData');
          messageList[messageId].messageText += jsonData['response'];
          notifyListeners();
          responseBuffer.clear();
        } catch (e) {
          print('there was an error');
        }
      },
      onDone: () {
        isResponding = false;
        completer.complete(responseBuffer.toString());
      },
      onError: (error) {
        print('Error receiving chunks: $error');
        completer.completeError(error);
      },
      cancelOnError: true,
    );
  }



}