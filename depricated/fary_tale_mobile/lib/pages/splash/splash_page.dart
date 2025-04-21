import 'package:fairy_tale_mobile/pages/tale_list/tale_list_page.dart';
import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Loaded1(),
    );
  }
}

class _Loaded1 extends StatefulWidget {
  const _Loaded1();

  @override
  State<_Loaded1> createState() => __Loaded1State();
}

class __Loaded1State extends State<_Loaded1> with StateHelpers {
  @override
  void initState() {
    super.initState();
    safeInitialize(() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const TaleListPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
