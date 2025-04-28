import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class CreateTaleForm extends StatelessWidget {
  const CreateTaleForm({super.key});

  @override
  Widget build(BuildContext context) {
    return VmWatcher<TaleViewModel>(
      builder: (context, vm, _) {
        return Center(
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                TextFieldComponent(
                  label: "Tale Title",
                  onChanged: vm.onChangeTaleTitle,
                  hintText: "The Enchanted Forest",
                ),

                ButtonComponent.primary(
                  text: "Create Tale",
                  icon: Icons.keyboard_arrow_right,
                  onPressed: vm.onSave,
                ).expanded(42),

                Text(
                  "You can customize more details after creating your tale",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
