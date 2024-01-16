
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_desktop_kit/cdk_app.dart';

import 'layout_chat.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  Widget _setLayout(BuildContext context) {
    return const CDKApp(
        defaultAppearance: "system", // system, light, dark
        defaultColor: "systemBlue",
        child: LayoutChat()
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(brightness: Brightness.dark),
      home: _setLayout(context),


    );
  }
}