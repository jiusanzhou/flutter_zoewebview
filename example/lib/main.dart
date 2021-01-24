import 'package:flutter/material.dart';
import 'package:flutter_zoewebview/provider.dart';
import 'package:flutter_zoewebview/webview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'ZoeWebview Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int process;
  String title;
  bool loading  = false;

  ZoeWebviewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar()
      ),
      body: ZoeWebview(
        initialUrl: "https://m.baidu.com",
        onWebViewCreated: (c) {
          _controller = c;
        },
        onLoadStart: (c, _) {
          setState(() {
            loading = true;
            title = _;
          });
        },
        onLoadStop: (c, _) {
          setState(() {
            loading = false;
          });
          _controller.getTitle().then((value) {
            setState(() {
              title = value;
            });
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.reload();
        },
        tooltip: '控制器',
        child: Icon(Icons.add), 
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
