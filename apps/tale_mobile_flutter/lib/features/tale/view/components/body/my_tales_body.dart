import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return VmProvider(
      vm: vm,
      builder: (context, _) {
        final crossAxisCount = context.width > 874 ? 4 : 3;
        return GridView(
          padding: EdgeInsets.only(top: 70, bottom: 12).h,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
          ),
          children: [for (final tale in vm.tales) _TaleCard(tale: tale)],
        );
        // return Wrap(
        // runSpacing: 16.h,
        // alignment: WrapAlignment.spaceBetween,
        // spacing: 0,
        // children: [for (final tale in vm.tales) _TaleCard(tale: tale)],
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
    // final width = context.width * .24;
    // final height = context.height * .55;
    final width = 200.w;
    final height = 340.h;
    return SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
        onTap: () {
          context.push(TaleView.route(tale.id));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8).r,
          ),
          elevation: 8,
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(height: height, color: Colors.indigo),
              ),
              Positioned(
                right: 6.w,
                top: 4.h,
                bottom: 4.h,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2).r,
                        bottomRight: Radius.circular(2).r,
                      ),
                    ),
                    width: 6.w,
                    height: height,
                  ),
                ),
              ),
              Positioned(
                child: Builder(
                  builder: (context) {
                    final imageWidth = width - (12 + 7).w;
                    //second positioned = 12, first positionioed = 7
                    final child =
                        tale.hasCoverImage
                            ? CachedNetworkImage(
                              imageUrl: tale.coverImageUrl,
                              fit: BoxFit.fill,
                              width: imageWidth,
                              height: height,
                              memCacheWidth: imageWidth.toInt(),
                              memCacheHeight: height.toInt(),
                              errorWidget:
                                  (context, error, stackTrace) =>
                                      const SizedBox(),
                            )
                            : const Placeholder();

                    return Card(
                      elevation: 32,
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(
                              topRight: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ).r,
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
                bottom: 12.h,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8).w,
                    child: Text(
                      tale.defaultLocaleTitle,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 22.sp,
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
  }
}
