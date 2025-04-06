import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view/components/body/page_viewer.dart';
import 'package:tale_builder_flutter/features/tale/view/tale_view.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.vm});

  final TaleViewModel vm;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TaleViewModel get vm => widget.vm;

  @override
  Widget build(BuildContext context) {
    return VmProvider(
      vm: vm,
      builder: (context, _) {
        final page = vm.selectedPage;
        return GestureDetector(
          // onTap: vm.onDeselectPage,
          child: Container(
            height: context.height,
            color: context.colorScheme.surface,
            alignment: Alignment.center,
            child:
                page != null
                    ? PageViewer(vm: vm)
                    : TextComponent.any(
                      "Page is not selected!",
                      style: context.textTheme.headlineSmall,
                    ),
          ),
        );
      },
    );
  }
}
