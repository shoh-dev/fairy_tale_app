import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:tale_buider_app/features/tale_editor/page.dart';
import 'package:tale_buider_app/features/tales/components/sidebar.dart';
import 'package:tale_buider_app/layout/default_layout.dart';

class TalesPage extends StatelessWidget {
  const TalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Tale>>(
      converter: (store) => store.state.talesState.tales,
      builder: (context, vm) {
        return DefaultLayout(
          leftSidebar: const TalesSidebarComponent(),
          title: const Text("Tales"),
          body: _Grid(tales: vm),
        );
      },
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({required this.tales});

  final List<Tale> tales;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
      ),
      itemCount: tales.length,
      itemBuilder: (context, index) {
        final tale = tales[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TaleEditorPage(taleId: tale.id)),
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    tale.coverImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(tale.title),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
