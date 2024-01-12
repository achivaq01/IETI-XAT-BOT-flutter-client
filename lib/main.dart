import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'App.dart';
import 'app_data.dart';

// MAIN function
void main() async {
  try {
    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      WidgetsFlutterBinding.ensureInitialized();
      await WindowManager.instance.ensureInitialized();
      windowManager.waitUntilReadyToShow().then(showWindow);
    }
  } catch (exception) {
    // TODO implement exception logs
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: App(),
    ),
  );
}

void showWindow(_) async {
  windowManager.setMinimumSize(const Size(300.0, 600.0));
  await windowManager.setTitle('App');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'IETI AI',
      home: MyHomePage(title: 'IETI TEST PAGE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Text('buenas'),
      
    );
  }
}
