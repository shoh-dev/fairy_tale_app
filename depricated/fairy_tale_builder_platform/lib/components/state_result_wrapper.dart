import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';

class StateResultWrapper extends StatelessWidget {
  const StateResultWrapper({
    required this.result,
    required this.onOk,
    super.key,
  });

  final StateResult result;
  final Widget onOk;

  @override
  Widget build(BuildContext context) {
    return result.when(
      ok: () => onOk,
      error: (error) => AppError(error: error),
      loading: () => const AppLoading(),
      initial: () => const AppInitial(),
    );
  }
}

class AppError extends StatelessWidget {
  const AppError({
    required this.error,
    super.key,
  });

  final ErrorX error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error.string()),
    );
  }
}

class AppInitial extends StatelessWidget {
  const AppInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
