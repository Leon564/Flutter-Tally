// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TallyFormWidget extends StatefulWidget {
  final String formId;
  final void Function()? onSubmit;
  final bool transparent;

  const TallyFormWidget({
    super.key,
    required this.formId,
    this.onSubmit,
    this.transparent = true,
  });

  @override
  State<TallyFormWidget> createState() => _TallyFormWidgetState();
}

class _TallyFormWidgetState extends State<TallyFormWidget> {
  late final WebViewController _controller;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();

    final baseUrl = 'https://tally.so/r/${widget.formId}';
    final url =
        widget.transparent
            ? '$baseUrl?transparentBackground=1'
            : '$baseUrl?embed=1';

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onNavigationRequest: (request) {
                if (request.url.contains('tally-confirm.local')) {
                  if (!_submitted) {
                    setState(() => _submitted = true);
                    widget.onSubmit?.call();
                  }
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_submitted)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.6),
              child: Center(
                child: Icon(Icons.check_circle, size: 100, color: Colors.green),
              ),
            ),
          ),
      ],
    );
  }
}
