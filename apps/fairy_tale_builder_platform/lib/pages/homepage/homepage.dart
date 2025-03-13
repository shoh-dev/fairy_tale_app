import 'package:fairy_tale_builder_platform/pages/homepage/components/appbar.dart';
import 'package:fairy_tale_builder_platform/pages/homepage/components/tale_list.dart';
import 'package:fairy_tale_builder_platform/pages/homepage/components/title.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/talepage.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'homepage.g.dart';

@TypedGoRoute<HomepageRoute>(
  path: '/',
  routes: [
    TypedGoRoute<TalepageRoute>(
      path: 'tale/:id',
    ),
  ],
)
class HomepageRoute extends GoRouteData {
  const HomepageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Homepage();
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  SliverToBoxAdapter space(double space) {
    return SliverToBoxAdapter(
      child: SizedBox(height: space),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: Sizes.kMaxWidth,
          child: CustomScrollView(
            slivers: [
              //AppBar
              const HomepageAppBar(),

              //space
              space(32),

              //Title and Description
              const HomepageTitle(),

              //space
              space(40),

              //tale list
              const HomepageTaleList(),
            ],
          ),
        ),
      ),
    );
  }
}

   // return DefaultLayout(
    //   leftSidebar: const TaleListSidebarComponent(),
    //   title: const Text('Tales'),
    //   body: StateConnector<AppState, TaleListState>(
    //     selector: (state) => state.taleListState,
    //     onInitialBuild: (dispatch, model) {
    //       dispatch(GetTaleListAction());
    //     },
    //     builder: (context, dispatch, vm) {
    //       return vm.listResult.when(
    //         ok: () {
    //           return _Grid(tales: vm.list);
    //         },
    //         error: (error) {
    //           return Center(child: Text(error.string()));
    //         },
    //         loading: () {
    //           return const LoadingComponent();
    //         },
    //         initial: () {
    //           return const SizedBox();
    //         },
    //       );
    //     },
    //   ),
    // );
 

// class _Grid extends StatelessWidget {
//   const _Grid({required this.tales});

//   final List<Tale> tales;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//       ),
//       itemCount: tales.length,
//       itemBuilder: (context, index) {
//         final tale = tales[index];
//         return InkWell(
//           onTap: () {
//             Navigator.of(context).push(
//               MaterialPageRoute<void>(
//                 builder: (context) => TaleEditorPage(taleId: tale.id),
//               ),
//             );
//           },
//           borderRadius: BorderRadius.circular(8),
//           child: Card(
//             child: Column(
//               children: [
//                 Expanded(
//                   child: tale.coverImage.isEmpty
//                       ? const Placeholder()
//                       : Image.network(
//                           //
//                           // ignore: lines_longer_than_80_chars
//                           '${tale.coverImage}?${DateTime.now().millisecondsSinceEpoch}',
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Translator(
//                     toTranslate: [tale.title],
//                     builder: (translatedValue) => Text(translatedValue[0]),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
