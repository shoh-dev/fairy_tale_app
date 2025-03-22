import 'package:fairy_tale_mobile/components/page_background.dart';
import 'package:fairy_tale_mobile/pages/tale/tale_page.dart';
import 'package:fairy_tale_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class HomepageTale extends StatelessWidget {
  const HomepageTale({
    required this.tale,
    super.key,
  });

  final Tale tale;

  @override
  Widget build(BuildContext context) {
    final width = context.width * .23;
    final height = context.height * .6;
    final borderRadius = BorderRadius.circular(12);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => Talepage(taleId: tale.id),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: borderRadius,
        child: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: context.colorScheme.primary),
          ),
          child: Stack(
            children: [
              PageBackground(
                url: tale.coverImage,
                opacity: .9,
                size: Size(
                  width,
                  height,
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
                        BoxShadow(
                          color: Colors.black.withAlpha(40),
                          blurRadius: 16,
                        ),
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
                      style: context.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w800,
                        shadows: [
                          AppUI.defaultShadow,
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
