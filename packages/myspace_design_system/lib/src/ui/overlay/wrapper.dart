import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

final overlayObserver = BotToastNavigatorObserver();

class OverlayWrapper extends StatelessWidget {
  const OverlayWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BotToastInit()(context, child);
  }
}

CancelFunc showLoadingDialog({bool barrierDismissible = false}) {
  return BotToast.showCustomLoading(
    toastBuilder: (cancelFunc) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    },
    clickClose: barrierDismissible,
    backgroundColor: Colors.black38,
    allowClick: false,
    backButtonBehavior: BackButtonBehavior.ignore,
  );
}

CancelFunc showErrorMessage(String message) {
  return BotToast.showText(
    text: message,
    contentColor: Colors.red,
    backgroundColor: Colors.black38,
    backButtonBehavior: BackButtonBehavior.ignore,
  );
}
