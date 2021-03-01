import 'package:flutter/material.dart';
import 'package:flutter_application_1/hhh_inputer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HHHInputer(
                    labelList: ["你好", "好的好的", "你真棒", "i'm fine", "thank you"],
                    unUsedLabelList: ["再见","拜拜","嗯嗯嗯"],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
