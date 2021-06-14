import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_zoewebview/flutter_zoewebview.dart';

///ZoeWebview is a custom webview to wraper all kinds
///of webview we offered by plugins.
class ZoeWebview extends StatefulWidget {
  ZoeWebview({
    Key key,
    this.webviewType = WebviewType.InappWebview,

    this.initialUrl = "about:blank",
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
  _ZoeWebviewState createState() => _ZoeWebviewState();

  final WebviewType webviewType;
  
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

class _ZoeWebviewState extends State<ZoeWebview> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    switch (widget.webviewType) {
      case WebviewType.InappWebview:
        return ZoeInappWebview(
          initialUrl: widget.initialUrl, initialHeaders: widget.initialHeaders, userAgent: widget.userAgent,
          onWebViewCreated: widget.onWebViewCreated, onProgressChanged: widget.onProgressChanged,
          onLoadStart: widget.onLoadStart, onLoadStop: widget.onLoadStop, onLoadError: widget.onLoadError,
          onAjaxProgress: widget.onAjaxProgress, onAjaxReadyStateChange: widget.onAjaxReadyStateChange, onConsoleMessage: widget.onConsoleMessage,
          shouldInterceptAjaxRequest: widget.shouldInterceptAjaxRequest,
        );
      case WebviewType.OfficialWebview:
        return ErrorBlock(title: "unimplement");
      case WebviewType.PluginWebview:
        return ErrorBlock(title: "unimplement");
      default:
        return ErrorBlock(title: "unknown webview type: ${widget.webviewType}");
    }
  }
}

class ErrorBlock extends StatelessWidget {
  const ErrorBlock({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}