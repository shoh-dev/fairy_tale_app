import 'package:flutter/material.dart';

class TalePageBackroundComponent extends StatelessWidget {
  const TalePageBackroundComponent({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}
