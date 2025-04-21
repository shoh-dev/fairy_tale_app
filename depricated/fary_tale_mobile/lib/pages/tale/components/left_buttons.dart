import 'package:fairy_tale_mobile/components/icon_button.dart';
import 'package:fairy_tale_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class TalepageLeftButtons extends StatelessWidget {
  const TalepageLeftButtons({
    required this.currentPage,
    required this.totalPagesCount,
    super.key,
  });

  final int currentPage;
  final int totalPagesCount;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.titleSmall!.copyWith(
      color: Colors.blue,
      fontWeight: FontWeight.w800,
    );
    return Column(
      spacing: 4,
      children: [
        UIIconButton(
          onPressed:
              Navigator.canPop(context) ? () => Navigator.pop(context) : null,
          icon: Icons.home_rounded,
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
        ),
        //page counting
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppUI.maxBorderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: RichText(
              text: TextSpan(
                style: textStyle,
                children: [
                  TextSpan(text: currentPage.toString()),
                  TextSpan(
                    text: '/',
                    style: textStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text: totalPagesCount.toString(),
                    style: textStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        // UIIconButton(
        //   onPressed: () {},
        //   icon: Icons.mail_rounded,
        //   backgroundColor: Colors.blueAccent,
        //   foregroundColor: Colors.white,
        // ),
      ],
    );
  }
}
