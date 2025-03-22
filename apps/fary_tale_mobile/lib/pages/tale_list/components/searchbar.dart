import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class HomepageSearchBar extends StatelessWidget
    with StateConnectorMixin<String> {
  const HomepageSearchBar({super.key});

  @override
  Widget builder(
      BuildContext context, Dispatcher<AppState> dispatch, String model) {
    return SizedBox(
      width: 300,
      child: TextFieldComponent(
        initialValue: model,
        hintText: 'Search',
        onChanged: (value) {
          dispatch(UpdateSearchQueryAction(value));
        },
        suffixWidgets: (q) => [
          ButtonComponent.icon(
            icon: Icons.search,
            onPressed: q.isEmpty ? null : () => dispatch(GetTaleListAction()),
          ),
        ],
      ),
    );
  }

  @override
  String selector(AppState state) {
    return state.taleListState.searchQuery;
  }
}
