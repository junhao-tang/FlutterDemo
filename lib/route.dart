import 'package:flutter_demo/screens/settings.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/home.dart';
import 'package:flutter_demo/screens/playlist.dart';

enum RouteNames {
  home,
  playlist,
  settings,
}

final GoRouter routes = GoRouter(
  routes: [
    GoRoute(
      name: RouteNames.home.toString(),
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
      routes: <GoRoute>[
        GoRoute(
          name: RouteNames.playlist.toString(),
          path: 'playlist/:pid',
          builder: (BuildContext context, GoRouterState state) {
            int? pid = int.tryParse(state.params["pid"]!);
            if (pid == null) throw Exception();
            return PlaylistScreen(pid);
          },
        ),
        GoRoute(
          name: RouteNames.settings.toString(),
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsScreen();
          },
        ),
      ],
    ),
  ],
);
