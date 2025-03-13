import 'package:fairy_tale_builder_platform/components/pagenumber_selector.dart';
import 'package:fairy_tale_builder_platform/components/translation_selector.dart';
import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/actions/page_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalepagePageForm extends StatelessWidget
    with StateConnectorMixin<(TalePage?, Tale)> {
  const TalepagePageForm({super.key});

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    (TalePage?, Tale) model,
  ) {
    if (model.$1 == null) {
      return const Center(
        child: Text('Please select a page!'),
      );
    }

    return SizedBox(
      width: Sizes.kMaxWidth * .5,
      height: double.infinity,
      child: _Form(
        tale: model.$2,
        page: model.$1!,
      ),
    );
  }

  @override
  (TalePage?, Tale) selector(AppState state) =>
      (selectedPage(state), selectedTale(state));
}

class _Form extends StatefulWidget {
  const _Form({
    required this.page,
    required this.tale,
  });

  final Tale tale;
  final TalePage page;

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> with DispatchConnectorMixinState {
  TalePage get page => widget.page;
  Tale get tale => widget.tale;

  @override
  Widget builder(BuildContext context, Dispatcher<AppState> dispatch) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 32),
      children: [
        Text(
          'Page Details',
          style: context.textTheme.titleLarge!.copyWith(color: context.primary),
        ),
        space(),
        TranslationSelector(
          label: 'Page Title',
          textKey: page.text,
          isRequiredToSelect: true,
          onChanged: (value) {
            dispatch(UpdatePageAction(text: value));
          },
        ),
        space(),
        PagenumberSelector(
          pageNumber: page.pageNumber,
          onChanged: (value) {
            dispatch(UpdatePageAction(pageNumber: value));
          },
        ),
      ],
    );
  }

  Widget space([double height = 24]) {
    return SizedBox(height: height);
  }
}
