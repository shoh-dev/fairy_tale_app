import 'package:fairy_tale_mobile/components/icon_button.dart';
import 'package:flutter/material.dart';

class HomepageLeftButtons extends StatelessWidget {
  const HomepageLeftButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        UIIconButton(
          onPressed: () {},
          icon: Icons.settings_rounded,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        UIIconButton(
          onPressed: () {},
          icon: Icons.mail_rounded,
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
      ],
    );
  }
}
