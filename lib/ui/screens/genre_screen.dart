import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({super.key});

  final List<Map<String, dynamic>> genres = const [
    {
      'name': 'Action',
      'movies': [
        'assets/images/deadpool.jpg',
        'assets/images/batman.jpg',
        'assets/images/avatar.jpg',
        'assets/images/spiderman.jpg',
      ]
    },
    {
      'name': 'Adventure',
      'movies': [
        'assets/images/inter.jpg',
        'assets/images/lor.jpg',
        'assets/images/narnia.jpg',
        'assets/images/pirates.jpg',
      ]
    },
    {
      'name': 'Fantasy',
      'movies': [
        'assets/images/hp.jpg',
        'assets/images/httyd.jpg',
        'assets/images/narnia.jpg',
        'assets/images/lor.jpg',
      ]
    },
    {
      'name': 'Sci-Fi',
      'movies': [
        'assets/images/inter.jpg',
        'assets/images/avatar.jpg',
        'assets/images/mr.jpg',
      ]
    },
    {
      'name': 'Drama',
      'movies': [
        'assets/images/mr.jpg',
        'assets/images/inter.jpg',
      ]
    },
    {
      'name': 'Comedy',
      'movies': [
        'assets/images/deadpool.jpg',
        'assets/images/mr.jpg',
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              height: 52,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'GENRE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            
            // Genre List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: genres.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final genre = genres[index];
                  return Card(
                    color: const Color(0xFF1A1A1A),
                    child: ListTile(
                      title: Text(
                        genre['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.white54,
                      ),
                      onTap: () {
                        // Navigasi dengan go_router
                        context.push('/category/${genre['name']}');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}