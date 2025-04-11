import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_mobile_flutter/features/tale/model/tale.dart';
import 'package:tale_mobile_flutter/features/tale/view_model/my_tales_view_model.dart';

class MyTalesBody extends StatelessWidget {
  const MyTalesBody({super.key, required this.vm});

  final MyTalesViewModel vm;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 16,
        alignment: WrapAlignment.spaceBetween,
        children: [for (final tale in vm.tales) _Tale(tale: tale)],
      ),
    );
  }
}

class _Tale extends StatelessWidget {
  const _Tale({required this.tale});
  final TaleModel tale;

  @override
  Widget build(BuildContext context) {
    final width = context.width * .25;
    final height = context.height * .5;
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        child: Stack(
          children: [
            Positioned.fill(
              child:
                  tale.hasCoverImage
                      ? Image.network(
                        tale.coverImageUrl,
                        fit: BoxFit.fill,
                        width: width,
                        height: height,
                      )
                      : const Placeholder(),
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
                    tale.title,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: context.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w800,
                      shadows: [
                        BoxShadow(color: Colors.black45, offset: Offset(1, 1)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
