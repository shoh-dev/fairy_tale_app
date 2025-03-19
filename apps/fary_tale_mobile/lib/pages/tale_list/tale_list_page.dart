import 'package:fairy_tale_mobile/components/page_background.dart';
import 'package:fairy_tale_mobile/components/translator_component.dart';
import 'package:fairy_tale_mobile/pages/tale_list/components/tale.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/selected_tale_page.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TaleListPage extends StatelessWidget {
  const TaleListPage({super.key});

  static const route = '/tale_list';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Tales(),
    );
  }
}

class _Tales extends StatelessWidget {
  const _Tales();

  @override
  Widget build(BuildContext context) {
    return StateResultConnector<AppState>(
      selector: (state) => state.taleListState.listResult,
      onInitialBuild: (dispatch, viewModel) {
        dispatch(GetTaleListAction());
      },
      builder: (context, dispatch, result) {
        return result.when(
          ok: () {
            return const _Loaded();
          },
          error: (e) => Center(
            child: Text(e.toString()),
          ),
          loading: () {
            return const Center(child: CircularProgressIndicator.adaptive());
          },
          initial: () {
            return const SizedBox();
          },
        );
      },
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded();

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, List<Tale>>(
      selector: taleList,
      builder: (context, dispatch, taleList) {
        return SafeArea(
          bottom: false,
          child: RefreshIndicator.adaptive(
            onRefresh: () {
              dispatch(GetTaleListAction());
              return Future<void>.value();
            },

            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.settings),
                        Icon(Icons.mail),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.only(top: 64, bottom: 32),
                        children: [
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runSpacing: 24,
                            children: [
                              for (final tale in taleList)
                                HomepageTale(tale: tale),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        Icon(Icons.music_note),
                      ],
                    ),
                  ],
                ),
                Positioned.fill(
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(width: 300, child: TextField())),
                ),
              ],
            ),

            // child: ListView.builder(
            //   itemCount: taleList.length,
            //   itemBuilder: (context, index) {
            //     final tale = taleList[index];
            //     return Translator(
            //       toTranslate: [
            //         tale.title,
            //         tale.description,
            //       ],
            //       builder: (translatedValue) {
            //         return ListTile(
            //           leading: tale.coverImage.isEmpty
            //               ? const SizedBox(width: 60, child: Placeholder())
            //               : Image.network(
            //                   tale.coverImage,
            //                   fit: BoxFit.cover,
            //                 ),
            //           title: TextComponent.any(translatedValue[0]),
            //           onTap: () {
            //             Navigator.of(context).push(
            //               MaterialPageRoute<void>(
            //                 builder: (context) =>
            //                     SelectedTalePage(taleId: tale.id),
            //               ),
            //             );
            //           },
            //           subtitle: TextComponent.any(translatedValue[1]),
            //         );
            //       },
            //     );
            //   },
            // ),
          ),
        );
      },
    );
  }
}
