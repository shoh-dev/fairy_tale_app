import 'dart:developer';

import 'package:fairy_tale_builder_platform/manager/redux.dart';
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
  });

  final String imagePath;
  final ValueChanged<PlatformFile>? onImageSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.bodyMedium),
        if (imagePath.isNotEmpty)
          Image.network(
            '$imagePath?${DateTime.now().millisecondsSinceEpoch}',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
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

                  final result = await picker.pickFile(FileType.image);

                  result.when(
                    ok: (file) {
                      if (file == null) {
                        return;
                      }

                      if (file.files.isEmpty) {
                        return;
                      }

                      onImageSelected!(file.files.first);
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
      ],
    );
  }
}
