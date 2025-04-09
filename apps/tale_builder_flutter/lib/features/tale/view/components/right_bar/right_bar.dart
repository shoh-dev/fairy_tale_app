import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view/components/right_bar/forms/page.dart';
import 'package:tale_builder_flutter/features/tale/view/components/right_bar/forms/tale.dart';
import 'package:tale_builder_flutter/features/tale/view/components/right_bar/forms/text.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class RightBar extends StatefulWidget {
  const RightBar({super.key, required this.vm});

  final TaleViewModel vm;

  @override
  State<RightBar> createState() => _RightBarState();
}

class _RightBarState extends State<RightBar> {
  TaleViewModel get vm => widget.vm;

  @override
  Widget build(BuildContext context) {
    final text = vm.selectedText;
    final page = vm.selectedPage;

    return CommandWrapper(
      command: vm.fetchTaleCommand,
      okBuilder: (BuildContext context, Widget? child) => child!,
      child: SizedBox(
        height: context.height,
        child: ListView(
          children: [
            RepaintBoundary(
              child: LayoutComponent.row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.settings_outlined, size: 18),
                  TextComponent.any(
                    'Properties',
                    style: context.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            RightBarTaleForm(vm: vm),

            // const Divider(),
            if (page != null) ...[
              const SizedBox(height: 16),
              RightBarPageForm(vm: vm, page: page),
            ],
            if (text != null) ...[
              const SizedBox(height: 16),
              RightBarTextForm(vm: vm, text: text),
            ],
          ],
        ),
      ),
    );
  }
}
