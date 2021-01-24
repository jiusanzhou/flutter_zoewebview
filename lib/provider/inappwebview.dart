import 'package:flutter/material.dart';
import 'package:flutter_zoewebview/flutter_zoewebview.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ZoeInappWebview extends StatefulWidget {
  ZoeInappWebview({
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
  _ZoeInappWebviewState createState() => _ZoeInappWebviewState();


  final String initialUrl;
  final Map<String, String> initialHeaders;
  final String userAgent;


  ///Event fired when the [WebView] is created.
  final void Function(ZoeWebviewController controller) onWebViewCreated;

  ///Event fired when the [WebView] starts to load an [url].
  final void Function(ZoeWebviewController controller, String url) onLoadStart;

  ///Event fired when the [WebView] finishes loading an [url].
  final void Function(ZoeWebviewController controller, String url) onLoadStop;

  ///Event fired when the [WebView] encounters an error loading an [url].
  final void Function(ZoeWebviewController controller, String url, int code, String message) onLoadError;

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

class _ZoeInappWebviewState extends State<ZoeInappWebview> {

  InappWebviewControllerZoe _controller;

  @override
  void initState() {
    super.initState();
    _controller = InappWebviewControllerZoe(widget);
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrl: widget.initialUrl,
      onWebViewCreated: _onWebViewCreated,
      onLoadStart: _onLoadStart,
      onLoadStop: _onLoadStop,
      onLoadError: _onLoadError,
      onProgressChanged: _onProgressChanged,
    );
  }

  void _onWebViewCreated(InAppWebViewController controller) {
    _controller._controller = controller;
    widget.onWebViewCreated?.call(_controller);
  }

  void _onLoadStart(InAppWebViewController controller, String url) {
    widget.onLoadStart?.call(_controller, url);
  }

  void _onLoadStop(InAppWebViewController controller, String url) {
    widget.onLoadStop?.call(_controller, url);
  }

  void _onLoadError(InAppWebViewController controller, String url, int code, String message) {
    widget.onLoadError?.call(_controller, url, code, message);
  }

  void _onProgressChanged(InAppWebViewController controller, int progress) {
    widget.onProgressChanged.call(_controller, progress);
  }
}

class InappWebviewControllerZoe extends ZoeWebviewController {
  ZoeInappWebview _widget;

  InAppWebViewController _controller;

  InappWebviewControllerZoe(this._widget) : super(_widget);

  @override
  Future<String> getUrl() {
    return _controller.getUrl();
  }

  @override
  Future<String> getTitle() {
    return _controller.getTitle();
  }

  @override
  Future<String> getHtml() {
    return _controller.getHtml();
  }

  @override
  Future<int> getProgress() {
    return _controller.getProgress();
  }

  @override
  Future<void> loadUrl({String url, Map<String, String> headers = const {}}) {
    return _controller.loadUrl(url: url, headers: headers);
  }

  @override
  Future<void> reload() {
    return _controller.reload();
  }

  @override
  Future evaluateJavascript(String code) {
    return _controller.evaluateJavascript(source: code);
  }
}