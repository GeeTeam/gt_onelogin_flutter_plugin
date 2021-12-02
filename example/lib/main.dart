import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:gt_onelogin_flutter_plugin/gt_onelogin_flutter_plugin.dart';

const androidOLAppId = "b41a959b5cac4dd1277183e074630945";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    String appId;
    if (Platform.isAndroid) {
      appId = androidOLAppId;
    } else {
      //TODO appId
      appId = "xxx";
    }
    GtOneloginFlutterPlugin.init(appId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Welcome to Geetest OneLogin\n'),
              TextButton(
                  onPressed: () {
                    GtOneloginFlutterPlugin.requestToken();
                  },
                  child: const Text("OneLogin start")),
            ],
          ),
        ),
      ),
    );
  }
}
