import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:flutter/widgets.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class PagenumberSelector extends StatelessWidget with StateConnectorMixin<int> {
  const PagenumberSelector({
    required this.pageNumber,
    required this.onChanged,
    this.hasLabel = true,
    super.key,
  });

  final int pageNumber;
  final void Function(int) onChanged;
  final bool hasLabel;

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    int model,
  ) {
    return DropdownComponent<int>(
      label: hasLabel ? 'Page Number' : null,
      initialValue: DropdownItem(
        value: pageNumber,
        label: pageNumber.toString(),
      ),
      onChanged: (value, controller) {
        if (value == null || value.value == pageNumber) {
          return;
        }
        onChanged(value.value);
      },
      items: [
        for (final value in [for (int i = 1; i <= model; i++) i])
          DropdownItem(
            value: value,
            enabled: value != pageNumber,
            label: value.toString(),
          ),
      ],
    );
  }

  @override
  int selector(AppState state) {
    return state.selectedTaleState.pages.length;
  }
}
