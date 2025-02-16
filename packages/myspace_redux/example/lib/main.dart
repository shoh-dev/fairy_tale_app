import 'package:flutter/material.dart';
import 'package:myspace_redux/myspace_redux.dart';

class MyDependency {
  void doSomething() {
    print('MyDependency.doSomething()');
  }

  void doSomethingElse() {
    print('MyDependency.doSomethingElse()');
  }
}

class MyDependency2 {
  final MyDependency myDependency;

  const MyDependency2(this.myDependency);

  void doSomething() {
    print('MyDependency2.doSomething()');
  }

  void doSomethingElse() {
    print('MyDependency2.doSomethingElse()');
  }
}

void main() {
  final appStore = AppStore();

  appStore.registerSingleton<MyDependency>(MyDependency());
  appStore.registerSingleton<MyDependency2>(MyDependency2(appStore.getDependency<MyDependency>()));

  runApp(AppStoreProvider(
    appStore: appStore.createStore(),
    child: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final myDependency = context.getDependency<MyDependency>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('MySpace Redux Example'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: myDependency.doSomething,
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: myDependency.doSomethingElse,
            ),
          ],
        ),
        body: Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}
