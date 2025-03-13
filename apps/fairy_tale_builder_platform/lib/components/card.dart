import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class DefaultCard extends StatefulWidget {
  const DefaultCard({
    required this.title,
    super.key,
    this.subTitle,
    this.bottomSubTitle,
    required this.bottomTitle,
    this.image,
    this.onTap,
    this.size = const Size(240, 260),
  });

  final String title;
  final String? subTitle;
  final String bottomTitle;
  final String? bottomSubTitle;
  final Size size;
  final ImageProvider? image;
  final VoidCallback? onTap;

  @override
  State<DefaultCard> createState() => _DefaultCardState();
}

class _DefaultCardState extends State<DefaultCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final radius = (context.theme.cardTheme.shape! as RoundedRectangleBorder)
        .borderRadius as BorderRadius;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          hovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          hovering = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: !hovering
                ? null
                : Border.all(
                    color: context.colorScheme.primary,
                  ),
          ),
          width: widget.size.width,
          height: widget.size.height,
          child: ClipRRect(
            borderRadius: radius,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //stack with image on the background and text on top
                Expanded(
                  child: SizedBox(
                    width: widget.size.width,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: widget.image != null
                              ? AnimatedScale(
                                  duration: const Duration(milliseconds: 200),
                                  scale: hovering ? 1.1 : 1,
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image: widget.image!,
                                  ),
                                )
                              : const Placeholder(),
                        ),
                        Positioned(
                          bottom: 0,
                          height: widget.size.height * .3,
                          width: widget.size.width,
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
                          bottom: widget.size.width * .15,
                          child: Text(
                            widget.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (widget.subTitle != null)
                          Positioned(
                            left: 12,
                            right: 12,
                            bottom: widget.size.width * .05,
                            child: Text(
                              widget.subTitle!,
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
                          widget.bottomTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelSmall!.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      if (widget.bottomSubTitle != null)
                        Expanded(
                          child: Text(
                            widget.bottomSubTitle!,
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
      ),
    );
  }
}
