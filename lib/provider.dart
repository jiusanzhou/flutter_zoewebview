import 'package:flutter/material.dart';

///WebviewType is a enum contains webview type
///if we implement other webview plugin.
///Add field to WebviewType
enum WebviewType {
  OfficialWebview,
  PluginWebview,
  InappWebview,
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
}