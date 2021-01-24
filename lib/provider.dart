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

  ZoeWebviewController(this._widget);

  ///Gets the URL for the current page.
  Future<String> getUrl() async {

  }

  ///Gets the title for the current page.
  Future<String> getTitle() async {

  }
  
  ///Gets the progress for the current page. The progress value is between 0 and 100.
  Future<int> getProgress() async {
    
  }

  ///Gets the content html of the page. It first tries to get the content through javascript.
  Future<String> getHtml() async {

  }

  ///Loads the given [url] with optional [headers] specified as a map from name to value.
  Future<void> loadUrl(
      {@required String url, Map<String, String> headers = const {}}) async {
    assert(url != null && url.isNotEmpty);

  }

  ///Evaluates JavaScript code into the WebView and returns the result of the evaluation.
  Future<dynamic> evaluateJavascript(String code) async {

  }

  Future<void> reload() async {

  }
}