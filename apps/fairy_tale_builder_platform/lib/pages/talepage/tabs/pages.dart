import 'package:fairy_tale_builder_platform/components/image_selector.dart';
import 'package:fairy_tale_builder_platform/components/pagenumber_selector.dart';
import 'package:fairy_tale_builder_platform/components/preview.dart';
import 'package:fairy_tale_builder_platform/components/state_result_wrapper.dart';
import 'package:fairy_tale_builder_platform/components/translation_selector.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/components/pagecard.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalepagePages extends StatelessWidget with StateResultConnectorMixin {
  const TalepagePages({super.key});

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    StateResult model,
  ) {
    return StateResultWrapper(
      result: model,
      onOk: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 32,
        children: [
          _PageList(),
          SizedBox(
            width: Sizes.kMaxWidth * .4,
            child: _FormWrapper(),
          ),
          SizedBox(
            width: Sizes.kMaxWidth * .3,
            child: _Metadata(),
          ),
        ],
      ),
    );
  }

  @override
  StateResult selector(AppState state) => state.selectedTaleState.taleResult;
}

class _PageList extends StatelessWidget
    with StateConnectorMixin<List<TalePage>> {
  const _PageList();

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    List<TalePage> model,
  ) {
    final pages = List.of(model)
      ..sort((a, b) => a.pageNumber > b.pageNumber ? 1 : 0);
    return Container(
      width: Sizes.kMaxWidth * .25,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: context.borderRadius,
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  'Pages',
                  style: context.textTheme.titleMedium,
                ),
                const Spacer(),
                ButtonComponent.text(
                  text: 'Add Page',
                  icon: Icons.add_rounded,
                  onPressed: () {
                    dispatch(AddPageAction());
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: pages.isEmpty
                ? const Center(
                    child: Text('No pages!'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      final page = pages[index];
                      return Pagecard(page: page);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  List<TalePage> selector(AppState state) => state.selectedTaleState.pages;
}

class _FormWrapper extends StatelessWidget with StateConnectorMixin<TalePage?> {
  const _FormWrapper();

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    TalePage? model,
  ) {
    if (model == null) {
      return const Center(
        child: Text('Please select a page!'),
      );
    }

    return SizedBox(
      width: Sizes.kMaxWidth * .5,
      height: double.infinity,
      child: _Form(page: model),
    );
  }

  @override
  TalePage? selector(AppState state) => selectedPage(state);
}

class _Form extends StatefulWidget {
  const _Form({
    required this.page,
  });

  final TalePage page;

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> with DispatchConnectorMixinState {
  TalePage get page => widget.page;

  @override
  Widget builder(BuildContext context, Dispatcher<AppState> dispatch) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 32),
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Page Details',
              style: context.textTheme.titleLarge!
                  .copyWith(color: context.primary),
            ),
            const Spacer(),
            ButtonComponent.outlined(
              text: 'Preview',
              onPressed: () => Preview.dialog(context),
            ),
          ],
        ),
        space(),
        TranslationSelector(
          label: 'Page Title',
          textKey: page.text,
          isRequiredToSelect: true,
          onChanged: (value) => dispatch(UpdatePageAction(text: value)),
        ),
        space(),
        PagenumberSelector(
          pageNumber: page.pageNumber,
          onChanged: (value) => dispatch(UpdatePageAction(pageNumber: value)),
        ),
        space(),
        ButtonComponent.destructive(
          text: 'Delete Page',
          icon: Icons.delete_outline_rounded,
          //todo: show confirmation first
          onPressed: () => dispatch(DeletePageAction()),
        ),
      ],
    );
  }

  Widget space([double height = 24]) {
    return SizedBox(height: height);
  }
}

class _Metadata extends StatelessWidget
    with StateConnectorMixin<(Tale, TalePage)> {
  const _Metadata();

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    (Tale, TalePage) model,
  ) {
    return ImageSelectorComponent(
      title: 'Background Image',
      imagePath: model.$2.metadata.backgroundImageUrl,
      size: Sizes.deviceSize(model.$1.isPortrait) / 2,
      recommendedSize: Sizes.deviceSize(model.$1.isPortrait),
      onImageSelected: (value) =>
          dispatch(UpdatePageAction(backgroundImageFile: value)),
    );
  }

  @override
  (Tale, TalePage) selector(AppState state) {
    return (selectedTale(state), selectedPage(state)!);
  }
}
