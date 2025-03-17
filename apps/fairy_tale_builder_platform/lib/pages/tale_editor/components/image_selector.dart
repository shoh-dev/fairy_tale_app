import 'dart:developer';

import 'package:fairy_tale_builder_platform/manager/redux.dart';
import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class ImageSelectorComponent extends StatelessWidget {
  const ImageSelectorComponent({
    required this.title,
    super.key,
    this.imagePath = '',
    this.onImageSelected,
    this.onImageRemoved,
    this.recommendedSize,
  });

  final String imagePath;
  final ValueChanged<PlatformFile>? onImageSelected;
  final VoidCallback? onImageRemoved;
  final String title;
  final Size? recommendedSize;

  @override
  Widget build(BuildContext context) {
    final recommendedSize = this.recommendedSize ?? const Size(200, 200);
    return Stack(
      fit: StackFit.passthrough,
      children: [
        // Positioned.fill(
        //   child: Align(
        //     alignment: Alignment.centerRight,
        //     child: Text(
        //       '${recommendedSize.width}',
        //     ),
        //   ),
        // ),
        Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title${"\nRecommended size ${recommendedSize.width.toInt()} x ${recommendedSize.height.toInt()}"}",
              style: context.textTheme.bodyMedium,
            ),
            if (imagePath.isNotEmpty)
              Image.network(
                '$imagePath?${DateTime.now().millisecondsSinceEpoch}',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return const Placeholder();
                },
              ),
            ButtonComponent.primary(
              onPressed: onImageSelected == null
                  ? null
                  : () async {
                      final picker = context
                          .getDependency<DependencyInjection>()
                          .filePickerService;

                      final result = await picker.pickPNGFile();

                      result.when(
                        ok: (file) {
                          if (file == null) {
                            return;
                          }

                          onImageSelected!(file);
                        },
                        error: (e) {
                          //todo: show error
                          log(e.toString());
                        },
                      );
                    },
              icon: Icons.image_rounded,
              text: imagePath.isEmpty ? 'Select Image' : 'Replace Image',
            ),
            if (onImageRemoved != null)
              ButtonComponent.destructive(
                text: 'Remove Image',
                icon: Icons.delete_rounded,
                onPressed: imagePath.isNotEmpty ? onImageRemoved : null,
              ),
          ],
        ),
      ],
    );
  }
}
