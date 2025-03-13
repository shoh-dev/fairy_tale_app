// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homepage.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homepageRoute,
    ];

RouteBase get $homepageRoute => GoRouteData.$route(
      path: '/',
      factory: $HomepageRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'tale/:id',
          factory: $TalepageRouteExtension._fromState,
        ),
      ],
    );

extension $HomepageRouteExtension on HomepageRoute {
  static HomepageRoute _fromState(GoRouterState state) => const HomepageRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TalepageRouteExtension on TalepageRoute {
  static TalepageRoute _fromState(GoRouterState state) => TalepageRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/tale/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
