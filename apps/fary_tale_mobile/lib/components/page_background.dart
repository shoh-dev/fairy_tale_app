import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class PageBackground extends StatelessWidget {
  const PageBackground({
    required this.url,
    this.opacity = 1.0,
    this.size,
    super.key,
  });

  final String url;
  final double opacity;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return url.isNotEmpty
        ? Opacity(
            opacity: opacity,
            child: Image.network(
              url,
              fit: BoxFit.cover,
              width: size?.width,
              height: size?.height,
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
