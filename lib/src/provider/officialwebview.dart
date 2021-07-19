import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_zoewebview/flutter_zoewebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ZoeOfficialWebview extends StatefulWidget {
  const ZoeOfficialWebview({
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
  _ZoeOfficialWebviewState createState() => _ZoeOfficialWebviewState();


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
  final void Function(ZoeWebviewController controller, Uri uri, int code, String message) onLoadError;

  ///Event fired when the current [progress] of loading a page is changed.
  final void Function(ZoeWebviewController controller, int progress) onProgressChanged;

  ///Event fired when the [WebView] receives a [ConsoleMessage].
  final void Function(ZoeWebviewController controller, int level, String msg)onConsoleMessage;

  ///Event fired when an `XMLHttpRequest` is sent to a server.
  ///It gives the host application a chance to take control over the request before sending it.
  final Future<Map<String, dynamic>> Function(ZoeWebviewController controller, Map<String, dynamic> ajaxRequest) shouldInterceptAjaxRequest;

  ///Event fired whenever the `readyState` attribute of an `XMLHttpRequest` changes.
  ///It gives the host application a chance to abort the request.
  final Future<int> Function(ZoeWebviewController controller, Map<String, dynamic> ajaxRequest) onAjaxReadyStateChange;

  ///Event fired as an `XMLHttpRequest` progress.
  ///It gives the host application a chance to abort the request.
  final Future<int> Function(ZoeWebviewController controller, Map<String, dynamic> ajaxRequest) onAjaxProgress;
}

class _ZoeOfficialWebviewState extends State<ZoeOfficialWebview> {

  PluginWebviewControllerZoe _controller;

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.initialUrl,
      debuggingEnabled: false,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: _onWebViewCreated,
      onPageFinished: _onLoadStop,
      onPageStarted: _onLoadStart,
    );
  }

  void _onWebViewCreated(WebViewController controller) {
    _controller._controller = controller;
    widget.onWebViewCreated?.call(_controller);
  }

  void _onLoadStart(String url) {
    widget.onLoadStart?.call(_controller, Uri.parse(url));
  }

  void _onLoadStop(String url) {
    widget.onLoadStop?.call(_controller, Uri.parse(url));
  }
}

class PluginWebviewControllerZoe extends ZoeWebviewController {
  ZoeOfficialWebview _widget;

  WebViewController _controller;

  PluginWebviewControllerZoe(this._widget) : super(_widget);

  @override
  Future<String> getUrl() {
    return _controller.currentUrl().then((uri) => uri.toString());
  }

  @override
  Future<String> getTitle() {
    return _controller.getTitle();
  }

  @override
  Future<void> reload() {
    return _controller.reload();
  }

  @override
  Future evaluateJavascript(String code) {
    return _controller.evaluateJavascript(code).then((value) => jsonDecode(value));
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