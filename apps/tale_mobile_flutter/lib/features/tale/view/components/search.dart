import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class MyTalesSearch extends StatelessWidget {
  const MyTalesSearch({super.key, required this.onSearch});

  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: TextFieldComponent(
          hintText: "Search",
          onChanged: (value) {
            if (value.isEmpty) {
              onSearch('');
            }
          },
          canClear: true,
          maxLines: 1,
          suffixWidgets: (query) {
            return [
              ButtonComponent.iconOutlined(
                icon: Icons.search,
                onPressed: query.isNotEmpty ? () => onSearch(query) : null,
              ),
            ];
          },
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ).sized(width: 300),
      ),
    );
  }
}
