import 'package:flutter/widgets.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class TaleEditor extends StatefulWidget {
  const TaleEditor({super.key, required this.vm});

  final TaleViewModel vm;

  @override
  State<TaleEditor> createState() => _TaleEditorState();
}

class _TaleEditorState extends State<TaleEditor> {
  TaleViewModel get vm => widget.vm;

  @override
  Widget build(BuildContext context) {
    final tale = vm.tale;

    if (tale == null) return const SizedBox.shrink();

    return LayoutComponent.column(
      spacing: 16,
      children: [
        TextFieldComponent(label: 'Title', initialValue: tale.title),
        TextFieldComponent(
          label: 'Description',
          initialValue: tale.description,
        ),
      ],
    );
  }
}
