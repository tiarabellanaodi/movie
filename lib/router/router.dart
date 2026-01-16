import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:movie/ui/screens/main_screen.dart';
import 'package:movie/ui/screens/category_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
      routes: [
        GoRoute(
          path: 'category/:categoryName',
          builder: (context, state) {
            final categoryName = state.pathParameters['categoryName']!;
            return CategoryScreen(
              category: categoryName,
            );
          },
        ),
      ],
    ),
  ],
);