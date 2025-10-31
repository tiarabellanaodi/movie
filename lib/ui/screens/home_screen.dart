import 'package:flutter/material.dart';
import '../widget/now_playing_section.dart';
import '../widget/movie_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final trending = [
      'assets/images/spiderman.jpg',
      'assets/images/inter.jpg',
      'assets/images/hp.jpg',
      'assets/images/httyd.jpg', 
      'assets/images/lor.jpg',
      'assets/images/mr.jpg',
      'assets/images/deadpool.jpg',
      'assets/images/avatar.jpg',
    ];

    final popular = [
      'assets/images/httyd.jpg',
      'assets/images/narnia.jpg',
      'assets/images/pirates.jpg',
      'assets/images/batman.jpg',
      'assets/images/deadpool.jpg',
      'assets/images/mr.jpg',
    ];

    final topRated = [
      'assets/images/inter.jpg',
      'assets/images/hp.jpg',
      'assets/images/spiderman.jpg',
      'assets/images/hp.jpg',
      'assets/images/httyd.jpg',
      'assets/images/deadpool.jpg',
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const NowPlayingSection(),
              const SizedBox(height: 12),

              MovieSection(title: 'Trending', list: trending, posterHeight: 160),
              const SizedBox(height: 12),
              MovieSection(title: 'Popular', list: popular, posterHeight: 160),
              const SizedBox(height: 12),
              MovieSection(title: 'Top Rated', list: topRated, posterHeight: 160),
            ],
          ),
        ),
      ),
    );
  }
}