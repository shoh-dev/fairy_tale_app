// import 'package:fairy_tale_builder_platform/manager/redux/features/app/localization/action.dart';
// import 'package:fairy_tale_builder_platform/manager/redux/features/app/localization/state.dart';
// import 'package:fairy_tale_builder_platform/manager/redux/features/app/state.dart';
// import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/action.dart';
// import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
// import 'package:fairy_tale_builder_platform/manager/selector.dart';
// import 'package:fairy_tale_builder_platform/utils/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:myspace_data/myspace_data.dart';
// import 'package:myspace_design_system/myspace_design_system.dart';
// import 'package:shared/shared.dart';

// class LocalizationSettingsRightSidebarComponent extends StatelessWidget {
//   const LocalizationSettingsRightSidebarComponent({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return StateConnector<AppState, LocalizationState>(
//       selector: (state) => state.applicationState.localizationState,
//       builder: (context, dispatch, state) {
//         return Container(
//           width: Sizes.kLeftSidebarWidth,
//           height: context.height,
//           decoration: const BoxDecoration(
//             border: Border(
//               left: BorderSide(
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(Sizes.kLayoutPadding),
//             child: Column(
//               spacing: 8,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Settings',
//                   style: context.textTheme.titleLarge,
//                 ),
//                 Text(
//                   'Latest version',
//                   style: context.textTheme.titleSmall,
//                 ),
//                 const SizedBox(
//                   width: double.infinity,
//                   child: ButtonComponent.outlined(
//                     text: 'Add', //todo:
//                     icon: Icons.add_rounded,
//                   ),
//                 ),
//                 // _Locale(
//                 //   locale: state.locale,
//                 //   onChanged: (locale) {
//                 //     if (locale == state.locale) {
//                 //       return;
//                 //     }
//                 //     dispatch(GetTranslationsAction(newLocale: locale));
//                 //   },
//                 // ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _Locale extends StatelessWidget {
//   const _Locale({
//     required this.locale,
//     required this.onChanged,
//   });

//   final String locale;
//   final ValueChanged<String> onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownComponent<String>(
//       label: 'Locale',
//       initialValue: DropdownItem(value: locale, label: locale),
//       onChanged: (value) {
//         if (value == null) {
//           return;
//         }
//         onChanged(value.value);
//       },
//       items: [
//         for (final locale in ['en', 'ru'])
//           DropdownItem(
//             value: locale,
//             label: locale,
//           ),
//       ],
//     );
//   }
// }
