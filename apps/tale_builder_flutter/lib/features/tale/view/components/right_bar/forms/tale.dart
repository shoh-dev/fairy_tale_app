import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_builder_flutter/features/tale/view/components/default_locale_selector.dart';
import 'package:tale_builder_flutter/features/tale/view/components/orientation_selector.dart';
import 'package:tale_builder_flutter/features/tale/view/components/translation_selector.dart';
import 'package:tale_builder_flutter/features/tale/view/translations_view.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class RightBarTaleForm extends StatelessWidget {
  const RightBarTaleForm({super.key, required this.vm});

  final TaleViewModel vm;

  @override
  Widget build(BuildContext context) {
    final tale = vm.tale;
    final loc = vm.localization;
    return ExpansionTile(
      initiallyExpanded: true,
      childrenPadding: EdgeInsets.all(8),
      title: RepaintBoundary(
        child: LayoutComponent.row(
          spacing: 4,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.book_outlined, size: 18),
            TextComponent.any('Tale', style: context.textTheme.titleMedium),
          ],
        ),
      ),
      children: [
        ButtonComponent.outlined(
          text: "Translations Editor",
          icon: Icons.text_fields_outlined,
          onPressed: () => context.push(TranslationsView.route(vm.tale.id)),
        ).expanded(),
        const SizedBox(height: 16),
        //Tale Fields
        TranslationSelector(
          label: "Title",
          translations: loc.defaultTranslations,
          value: tale.title,
          onSelected: vm.onChangeTaleTitle,
        ),
        const SizedBox(height: 16),
        TranslationSelector(
          label: "Description",
          translations: loc.defaultTranslations,
          value: tale.description,
          onSelected: vm.onChangeTaleDescription,
        ),
        const SizedBox(height: 16),
        OrientationSelector(
          value: tale.orientation,
          onSelected: vm.onChangeTaleOrientation,
        ),
        const SizedBox(height: 16),

        DefaultLocaleSelector(
          locales: loc.availableLocales,
          label: "Default Locale",
          value: loc.defaultLocale,
          onSelected: vm.onChangeLocalizationDefaultLocale,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
