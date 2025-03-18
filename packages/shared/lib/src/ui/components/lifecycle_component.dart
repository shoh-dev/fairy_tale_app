import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class LifecycleComponent extends StatefulWidget {
  const LifecycleComponent({
    required this.child,
    super.key,
    this.onInitialize,
    this.onDispose,
    this.onAppBackground,
    this.onAppClosed,
    this.onAppResumed,
  });

  final Widget child;
  final FutureOr<void> Function()? onInitialize;
  final FutureOr<void> Function()? onDispose;
  final VoidCallback? onAppResumed;
  final VoidCallback? onAppClosed;
  final VoidCallback? onAppBackground;

  @override
  State<LifecycleComponent> createState() => _LifecycleComponentState();
}

class _LifecycleComponentState extends State<LifecycleComponent>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (widget.onInitialize != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await widget.onInitialize!();
      });
    }
  }

  @override
  Future<void> dispose() async {
    if (mounted) {
      if (widget.onDispose != null) {
        await widget.onDispose!();
      }
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log(state.toString());

    //onBackground
    final isBackground = state == AppLifecycleState.hidden ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused;

    if (isBackground && widget.onAppBackground != null) {
      widget.onAppBackground!();
    }

    //onClosed
    final isClosed = state == AppLifecycleState.detached;

    if (isClosed && widget.onAppClosed != null) {
      widget.onAppClosed!();
    }

    //onResumed
    final isResumed = state == AppLifecycleState.resumed;

    if (isResumed && widget.onAppResumed != null) {
      widget.onAppResumed!();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
