import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class PageBackground extends StatelessWidget {
  const PageBackground({
    required this.url,
    this.opacity = 1.0,
    super.key,
  });

  final String url;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return url.isNotEmpty
        ? Opacity(
            opacity: opacity,
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          )
        : Placeholder(
            child: Center(
              child: Text(
                'No background image',
                style: context.textTheme.titleLarge,
              ),
            ),
          );
  }
}
