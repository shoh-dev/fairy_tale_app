import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

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
    with StateHelpers, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (widget.onInitialize != null) {
      safeInitialize(() async {
        await widget.onInitialize!();
      });
    }
  }

  @override
  void dispose() {
    safeDispose(() async {
      if (widget.onDispose != null) {
        await widget.onDispose!();
      }
      WidgetsBinding.instance.removeObserver(this);
    });
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
