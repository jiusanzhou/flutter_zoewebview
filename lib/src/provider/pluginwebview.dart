import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_zoewebview/flutter_zoewebview.dart';

class ZoePluginWebview extends StatefulWidget {
  const ZoePluginWebview({
    Key key,
    this.initialUrl,
    this.initialHeaders,
    this.userAgent,
    this.onWebViewCreated,
    this.onLoadStart,
    this.onProgressChanged,
    this.onLoadStop,
    this.onLoadError,
    this.onConsoleMessage,
    this.shouldInterceptAjaxRequest,
    this.onAjaxReadyStateChange,
    this.onAjaxProgress,
  }) : super(key: key);

  @override
  _ZoePluginWebviewState createState() => _ZoePluginWebviewState();

  final String initialUrl;
  final Map<String, String> initialHeaders;
  final String userAgent;

  ///Event fired when the [WebView] is created.
  final void Function(ZoeWebviewController controller) onWebViewCreated;

  ///Event fired when the [WebView] starts to load an [url].
  final void Function(ZoeWebviewController controller, Uri ui) onLoadStart;

  ///Event fired when the [WebView] finishes loading an [url].
  final void Function(ZoeWebviewController controller, Uri uri) onLoadStop;

  ///Event fired when the [WebView] encounters an error loading an [url].
  final void Function(
          ZoeWebviewController controller, Uri uri, int code, String message)
      onLoadError;

  ///Event fired when the current [progress] of loading a page is changed.
  final void Function(ZoeWebviewController controller, int progress)
      onProgressChanged;

  ///Event fired when the [WebView] receives a [ConsoleMessage].
  final void Function(ZoeWebviewController controller, int level, String msg)
      onConsoleMessage;

  ///Event fired when an `XMLHttpRequest` is sent to a server.
  ///It gives the host application a chance to take control over the request before sending it.
  final Future<Map<String, dynamic>> Function(
          ZoeWebviewController controller, Map<String, dynamic> ajaxRequest)
      shouldInterceptAjaxRequest;

  ///Event fired whenever the `readyState` attribute of an `XMLHttpRequest` changes.
  ///It gives the host application a chance to abort the request.
  final Future<int> Function(
          ZoeWebviewController controller, Map<String, dynamic> ajaxRequest)
      onAjaxReadyStateChange;

  ///Event fired as an `XMLHttpRequest` progress.
  ///It gives the host application a chance to abort the request.
  final Future<int> Function(
          ZoeWebviewController controller, Map<String, dynamic> ajaxRequest)
      onAjaxProgress;
}

class _ZoePluginWebviewState extends State<ZoePluginWebview> {
  PluginWebviewControllerZoe _controller;

  @override
  void initState() {
    super.initState();
    _controller = PluginWebviewControllerZoe(widget);
    _controller._init();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.initialUrl,
      mediaPlaybackRequiresUserGesture: false,
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      withJavascript: true,
      resizeToAvoidBottomInset: true,
      appCacheEnabled: true,
      geolocationEnabled: true,
      initialChild: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class PluginWebviewControllerZoe extends ZoeWebviewController {
  ZoePluginWebview _widget;

  FlutterWebviewPlugin _controller;

  PluginWebviewControllerZoe(this._widget) : super(_widget);

  /// TODO: use constructor
  _init() {
    _controller = FlutterWebviewPlugin();

    _controller.onStateChanged.listen((WebViewStateChanged state) async {
      var uri = Uri.parse(state.url);
      switch (state.type) {
        case WebViewState.finishLoad:
          _widget.onLoadStop(this, uri);
          break;
        case WebViewState.startLoad:
          _widget.onLoadStart(this, uri);
          break;
        default:
          break;
      }
    });
  }

  @override
  Future<void> reload() {
    return _controller.reload();
  }

  @override
  Future evaluateJavascript(String code) {
    return _controller.evalJavascript(code).then((value) => jsonDecode(value));
  }

  @override
  Future<bool> canGoBack() {
    return _controller.canGoBack();
  }

  @override
  Future<void> goBack() async {
    return _controller.goBack();
  }
}
