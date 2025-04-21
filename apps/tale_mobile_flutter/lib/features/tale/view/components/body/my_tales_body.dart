import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_mobile_flutter/features/tale/model/tale.dart';
import 'package:tale_mobile_flutter/features/tale/view/tale_view.dart';
import 'package:tale_mobile_flutter/features/tale/view_model/my_tales_view_model.dart';

class MyTalesBody extends StatelessWidget {
  const MyTalesBody({super.key, required this.vm});

  final MyTalesViewModel vm;

  @override
  Widget build(BuildContext context) {
    if (vm.tales.isEmpty) {
      return Center(
        child: Text("No Tales found!", style: context.textTheme.titleLarge),
      );
    }
    return VmWatcher<MyTalesViewModel>(
      builder: (context, vm, _) {
        return GridView.count(
          padding: EdgeInsets.only(top: 70, bottom: 12),
          crossAxisCount: context.width > 874 ? 4 : 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [for (final tale in vm.tales) _TaleCard(tale: tale)],
        );
        // return SingleChildScrollView(
        //   padding: EdgeInsets.only(top: 70, bottom: 12).h,
        //   child: Wrap(
        //     runSpacing: 16.h,
        //     alignment: WrapAlignment.spaceBetween,
        //     children: [for (final tale in vm.tales) _TaleCard(tale: tale)],
        //   ),
        // );
      },
    );
  }
}

class _TaleCard extends StatelessWidget {
  const _TaleCard({required this.tale});
  final TaleModel tale;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, cc) {
        final width = cc.maxWidth;
        final height = cc.maxHeight;
        return SizedBox(
          width: width,
          height: height,
          child: GestureDetector(
            onTap: () => context.push(TaleView.route(tale.id)),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 8,
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(height: height, color: Colors.deepPurple),
                  ),
                  Positioned(
                    right: 6,
                    top: 4,
                    bottom: 4,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(3),
                            bottomRight: Radius.circular(3),
                          ),
                        ),
                        width: 7,
                        height: height,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Builder(
                      builder: (context) {
                        final imageWidth = width - 19;
                        //second positioned = 12, first positionioed = 7
                        final child =
                            tale.hasCoverImage
                                ? CachedNetworkImage(
                                  imageUrl: tale.coverImageUrl,
                                  fit: BoxFit.fill,
                                  width: imageWidth,
                                  height: height,
                                  errorWidget:
                                      (context, error, stackTrace) =>
                                          const SizedBox(),
                                  // memCacheWidth: imageWidth.toInt(),
                                  // memCacheHeight: height.toInt(),
                                )
                                : const Placeholder();

                        return Card(
                          elevation: 32,
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: child,
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: width,
                        height: height * .4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: 12,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          tale.defaultLocaleTitle,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: context.textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              BoxShadow(
                                color: Colors.black45,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
