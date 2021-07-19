import 'package:flutter/material.dart';
import 'package:flutter_zoewebview/flutter_zoewebview.dart';

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
  bool loading = false;

  ZoeWebviewController _controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(loading ? "加载中..." : title),
          centerTitle: true,
        ),
        body: ZoeWebview(
          initialUrl: "https://main.m.taobao.com",
          onWebViewCreated: (c) => _controller = c,
          onLoadStart: (c, _) {
            setState(() {
              loading = true;
              title = _.toString();
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: ControllBar(_controller), // This trailing comma makes auto-formatting nicer for build methods.
      ),
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return Future.value(false);
        }
        return Future.value(true);
      },
    );
  }
}

class ControllBar extends StatefulWidget {
  final ZoeWebviewController _controller;

  ControllBar(this._controller) : super();

  @override
  _ControllBarState createState() => _ControllBarState();
}

class _ControllBarState extends State<ControllBar> {
  bool _extend = true;
  bool _loading = false;

  double size = 58;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _extend ? double.infinity : size,
      height: size,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          Expanded(child: Container()),
          FloatingActionButton(
            onPressed: () {
              // TODO: if (_loading) widget._controller.stop()
              widget._controller.reload();
            },
            child: Icon(_loading ? Icons.close : Icons.refresh),
          )
        ],
      ),
    );
  }
}
