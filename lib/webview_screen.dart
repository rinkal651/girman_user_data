import 'package:flutter/material.dart';
import 'package:girman_user_data/girman_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum WebConfig {
  WEBSITE("girmantech.com", null),
  LINKEDIN("linkedin.com", "\\company\\girmantech\\");

  final String? path;
  final String host;
  const WebConfig(this.host, this.path);
}

class WebviewScreen extends StatefulWidget {
  final WebConfig config;

  const WebviewScreen({super.key, required this.config});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();

  static createInstance({required WebConfig webConfig}) {
    return WebviewScreen(config: webConfig);
  }
}

class _WebviewScreenState extends State<WebviewScreen> {
  late final WebViewController _controller = WebViewController();

  @override
  void initState() {
    super.initState();
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri(
          scheme: 'https',
          host: widget.config.host,
          path: widget.config.path,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GirmanAppbar(context, displayMenu: false),
      body: WebViewWidget(controller: _controller),
    );
  }
}
