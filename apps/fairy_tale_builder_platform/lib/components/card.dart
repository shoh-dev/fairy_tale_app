import 'package:fairy_tale_builder_platform/components/hover_widget.dart';
import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class DefaultCard extends StatelessWidget {
  const DefaultCard({
    required this.title,
    super.key,
    this.subTitle,
    this.bottomSubTitle,
    required this.bottomTitle,
    this.image,
    this.onTap,
    this.size = const Size(260, 320),
  });

  final String title;
  final String? subTitle;
  final String bottomTitle;
  final String? bottomSubTitle;
  final Size size;
  final ImageProvider? image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = (context.theme.cardTheme.shape! as RoundedRectangleBorder)
        .borderRadius as BorderRadius;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: HoverWidget(
        onTap: onTap,
        child: (hovering) => ClipRRect(
          borderRadius: radius,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //stack with image on the background and text on top
              Expanded(
                child: SizedBox(
                  width: size.width,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: image != null
                            ? AnimatedScale(
                                duration: const Duration(milliseconds: 200),
                                scale: hovering ? 1.1 : 1,
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: image!,
                                ),
                              )
                            : const Placeholder(),
                      ),
                      Positioned(
                        bottom: 0,
                        height: size.height * .2,
                        width: size.width,
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 16,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        right: 12,
                        bottom: size.width * .15,
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (subTitle != null)
                        Positioned(
                          left: 12,
                          right: 12,
                          bottom: size.width * .05,
                          child: Text(
                            subTitle!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                color: context.colorScheme.surfaceContainer,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        bottomTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelSmall!.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    if (bottomSubTitle != null)
                      Expanded(
                        child: Text(
                          bottomSubTitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelMedium!.copyWith(
                            color: context.primary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
