import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:movie/ui/screens/main_screen.dart';
import 'package:movie/ui/screens/genre_screen.dart';
import 'package:movie/ui/screens/favorite_screen.dart';
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
            // Contoh data - sesuaikan dengan kebutuhan
            List<String> movies = [];
            switch (categoryName.toLowerCase()) {
              case 'action':
                movies = [
                  'assets/images/deadpool.jpg',
                  'assets/images/batman.jpg',
                  'assets/images/spiderman.jpg',
                ];
                break;
              case 'trending':
                movies = [
                  'assets/images/spiderman.jpg',
                  'assets/images/inter.jpg',
                  'assets/images/hp.jpg',
                ];
                break;
              case 'popular':
                movies = [
                  'assets/images/httyd.jpg',
                  'assets/images/narnia.jpg',
                  'assets/images/pirates.jpg',
                ];
                break;
              default:
                movies = [
                  'assets/images/deadpool.jpg',
                  'assets/images/batman.jpg',
                ];
            }
            
            return CategoryScreen(
              category: categoryName,
              movies: movies,
            );
          },
        ),
      ],
    ),
  ],
);