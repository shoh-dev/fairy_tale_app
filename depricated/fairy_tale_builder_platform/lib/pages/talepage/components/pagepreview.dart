import 'package:fairy_tale_builder_platform/components/preview.dart';
import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class TalepagePagePreview extends StatelessWidget {
  const TalepagePagePreview({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border(
          left: BorderSide(color: Colors.grey.shade800),
          top: BorderSide(color: Colors.grey.shade800),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  'Preview',
                  style: context.textTheme.titleMedium,
                ),
                const Spacer(),
                ButtonComponent.text(
                  text: 'Expand',
                  icon: Icons.expand_rounded,
                  onPressed: () => Preview.dialog(context),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Preview(),
          ),
        ],
      ),
    );
  }
}
