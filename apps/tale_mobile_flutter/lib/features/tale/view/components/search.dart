import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class MyTalesSearch extends StatelessWidget {
  const MyTalesSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: TextFieldComponent(
          hintText: "Search",
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ).sized(width: 300),
      ),
    );
  }
}
