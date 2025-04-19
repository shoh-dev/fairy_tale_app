import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class MyTalesSearch extends StatelessWidget {
  const MyTalesSearch({super.key, required this.onSearch});

  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      // decoration: BoxDecoration(
      //   color: Colors.indigo.withAlpha(200),
      //   borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(20),
      //     bottomRight: Radius.circular(20),
      //   ),
      // ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12).h,
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
        ).sized(width: 300.w),
      ),
    );
  }
}
