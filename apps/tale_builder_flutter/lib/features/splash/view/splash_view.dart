import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_builder_flutter/features/splash/view_model/splash_view_model.dart';

class SplashView extends StatefulWidget {
  final SplashViewModel vm;

  const SplashView({super.key, required this.vm});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        context.replace("/tale/11111111-1111-1111-1111-111111111111");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator.adaptive());
  }
}
