import 'package:fairy_tale_builder_platform/components/image_selector.dart';
import 'package:fairy_tale_builder_platform/components/pagenumber_selector.dart';
import 'package:fairy_tale_builder_platform/components/translation_selector.dart';
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
        space(),
        ExpansionTile(
          initiallyExpanded: true,
          childrenPadding: const EdgeInsets.only(
            left: 16,
            bottom: 16,
            right: 16,
          ),
          title: const Text('Metadata'),
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            ImageSelectorComponent(
              title: 'Background Image',
              imagePath: page.metadata.backgroundImageUrl,
              recommendedSize: Sizes.deviceSize(tale.isPortrait),
              onImageSelected: (value) {
                dispatch(UpdatePageAction(backgroundImageFile: value));
              },
            ),
          ],
        ),
        space(),
        ButtonComponent.destructive(
          text: 'Delete Page',
          icon: Icons.delete_outline_rounded,
          onPressed: () {
            //todo: show confirmation first
            dispatch(DeletePageAction());
          },
        ),
      ],
    );
  }

  Widget space([double height = 24]) {
    return SizedBox(height: height);
  }
}
