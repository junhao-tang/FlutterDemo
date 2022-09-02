import 'package:flutter/material.dart';
import 'package:flutter_wheel/route.dart';
import 'package:go_router/go_router.dart';

void routerGoNamed(BuildContext context, RouteNames namedRoute,
    {Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra}) {
  context.goNamed(namedRoute.toString(), params: params);
}

void routerPop(BuildContext context) {
  context.pop();
}
