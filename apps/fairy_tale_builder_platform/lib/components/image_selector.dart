import 'dart:developer';

import 'package:fairy_tale_builder_platform/manager/services/file_picker_service.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
    final radius = context.borderRadius;

    final recommendedSize = this.recommendedSize ?? const Size(200, 200);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title (recommended: ${"${recommendedSize.width.toInt()} x ${recommendedSize.height.toInt()}"})",
          style: context.textTheme.bodyMedium,
        ),
        Container(
          width: Sizes.kMaxWidth * .5,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: radius,
          ),
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 16, bottom: 32),
          margin: const EdgeInsets.only(top: 4),
          child: Center(
            child: Stack(
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
                  spacing: 16,
                  children: [
                    if (imagePath.isNotEmpty)
                      ClipRRect(
                        borderRadius: radius,
                        child: Image.network(
                          '$imagePath?${DateTime.now().millisecondsSinceEpoch}',
                          width: recommendedSize.width,
                          height: recommendedSize.height,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return const Placeholder();
                          },
                        ),
                      ),
                    ButtonComponent.outlined(
                      onPressed: onImageSelected == null
                          ? null
                          : () async {
                              const picker = FilePickerService();

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
                      text:
                          imagePath.isEmpty ? 'Select Image' : 'Replace Image',
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
            ),
          ),
        ),
      ],
    );
  }
}
