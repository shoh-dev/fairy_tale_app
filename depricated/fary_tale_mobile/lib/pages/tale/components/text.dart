import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class TalepageText extends StatelessWidget {
  const TalepageText({
    required this.text,
    required this.onNext,
    required this.onPrev,
    super.key,
  });

  final String text;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //left button
        ButtonComponent.icon(
          backgroundColor: Colors.transparent,
          onPressed: onPrev,
          foregroundColor: Colors.white,
          icon: Icons.chevron_left_rounded,
          iconSize: 64,
        ),

        //text with container
        Expanded(
          child: Container(
            height: 80,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 16,
            ),
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: context.textTheme.labelLarge!.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),

        //rigth button
        ButtonComponent.icon(
          backgroundColor: Colors.transparent,
          onPressed: onNext,
          foregroundColor: Colors.white,
          icon: Icons.chevron_right_rounded,
          iconSize: 64,
        ),
      ],
    );
  }
}
