import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';

class ImageSelectorComponent extends StatelessWidget {
  const ImageSelectorComponent({
    super.key,
    this.imagePath = '',
    this.onImageSelected,
    required this.title,
  });

  final String imagePath;
  final ValueChanged<void>? onImageSelected;
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
            imagePath,
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
        ButtonComponent.primary(
          onPressed: onImageSelected == null
              ? null
              : () async {
                  //todo: implement image selection
                },
          icon: Icons.image_rounded,
          text: imagePath.isEmpty ? "Select Image" : "Replace Image",
        ),
      ],
    );
  }
}
