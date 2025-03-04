import 'package:flutter/material.dart';

class SelectedTalePageBackroundComponent extends StatelessWidget {
  const SelectedTalePageBackroundComponent({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}
