import 'package:flutter/material.dart';
import 'package:flutter_zoewebview/flutter_zoewebview.dart';

///Event fired when the [WebView] is created.
typedef OnWebViewCreatedCallback = void Function(ZoeWebviewController controller);

///Event fired when the [WebView] starts to load an [url].
typedef OnLoadStartCallback = void Function(ZoeWebviewController controller, String url);

///Event fired when the [WebView] finishes loading an [url].
typedef OnLoadStopCallback = void Function(ZoeWebviewController controller, String url);

///Event fired when the [WebView] encounters an error loading an [url].
typedef OnLoadErrorCallback = void Function(ZoeWebviewController controller, String url, int code, String message);

///Event fired when the current [progress] of loading a page is changed.
typedef OnProgressChangedCallback = void Function(ZoeWebviewController controller, int progress);

///Event fired when the [WebView] receives a [ConsoleMessage].
typedef OnConsoleMessageCallback = void Function(ZoeWebviewController controller, int level, String msg);

///Event fired when an `XMLHttpRequest` is sent to a server.
///It gives the host application a chance to take control over the request before sending it.
typedef ShouldInterceptAjaxRequestCallback =  Future<Map<String, dynamic>> Function(ZoeWebviewController controller, Map<String, dynamic> ajaxRequest);

///Event fired whenever the `readyState` attribute of an `XMLHttpRequest` changes.
///It gives the host application a chance to abort the request.
typedef OnAjaxReadyStateChangeCallback =  Future<int> Function(ZoeWebviewController controller, Map<String, dynamic> ajaxRequest);

///Event fired as an `XMLHttpRequest` progress.
///It gives the host application a chance to abort the request.
typedef OnAjaxProgressCallback =  Future<int> Function(ZoeWebviewController controller, Map<String, dynamic> ajaxRequest);

///WebviewType is a enum contains webview type
///if we implement other webview plugin.
///Add field to WebviewType
enum WebviewType {
  OfficialWebview,
  PluginWebview,
  InappWebview,
}

extension WebviewTypeExt on WebviewType {

  Widget build({
    String initialUrl,
    Map<String, String> initialHeaders,
    String userAgent,

    OnWebViewCreatedCallback onWebViewCreated,

    OnLoadStartCallback onLoadStart,
    OnProgressChangedCallback onProgressChanged,
    OnLoadStopCallback onLoadStop,
    OnLoadErrorCallback onLoadError,

    OnConsoleMessageCallback onConsoleMessage,

    ShouldInterceptAjaxRequestCallback shouldInterceptAjaxRequest,
    OnAjaxReadyStateChangeCallback onAjaxReadyStateChange,
    OnAjaxProgressCallback onAjaxProgress,
  }) {

    final builders = <WebviewType, Widget Function({
      String initialUrl,
      Map<String, String> initialHeaders,
      String userAgent,

      OnWebViewCreatedCallback onWebViewCreated,

      OnLoadStartCallback onLoadStart,
      OnProgressChangedCallback onProgressChanged,
      OnLoadStopCallback onLoadStop,
      OnLoadErrorCallback onLoadError,

      OnConsoleMessageCallback onConsoleMessage,

      ShouldInterceptAjaxRequestCallback shouldInterceptAjaxRequest,
      OnAjaxReadyStateChangeCallback onAjaxReadyStateChange,
      OnAjaxProgressCallback onAjaxProgress,
    })>{

    };

    return builders[this]?.call();
  }

}



abstract class ZoeWebviewController {
  Widget _widget;

  final String _jsTitle = "document.title";
  final String _jsUrl = "document.location.href";
  final String _jsCallReload = "document.location.reload()";

  ZoeWebviewController(this._widget);

  ///Gets the URL for the current page.
  Future<String> getUrl() async {
    return evaluateJavascript(_jsUrl);
  }

  ///Gets the title for the current page.
  Future<String> getTitle() async {
    return evaluateJavascript(_jsTitle);
  }
  
  ///Gets the progress for the current page. The progress value is between 0 and 100.
  Future<int> getProgress() async {
    return Future.error("unimplement");
  }

  ///Gets the content html of the page. It first tries to get the content through javascript.
  Future<String> getHtml() async {
    return Future.error("unimplement");
  }

  ///Loads the given [url] with optional [headers] specified as a map from name to value.
  Future<void> loadUrl(
      {@required String url, Map<String, String> headers = const {}}) async {
    assert(url != null && url.isNotEmpty);
    // TODO: how to set headers
    evaluateJavascript("$_jsUrl=$url");
    return;
  }

  ///Evaluates JavaScript code into the WebView and returns the result of the evaluation.
  Future<dynamic> evaluateJavascript(String code) async {
    return Future.error("unimplement");
  }

  Future<void> reload() async {
    evaluateJavascript("$_jsCallReload");
  }

  Future<bool> canGoBack() async {
    return Future.error("unimplement");
  }

  Future<void> goBack() async {
    return Future.error("unimplement");
  }
}