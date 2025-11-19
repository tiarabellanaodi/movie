import 'package:flutter/material.dart';

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

  void _navigateToGenreDetail(BuildContext context, String genreName, List<String> movies) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GenreDetailScreen(
          genreName: genreName,
          movies: movies,
        ),
      ),
    );
  }

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
                      onTap: () => _navigateToGenreDetail(
                        context,
                        genre['name'],
                        List<String>.from(genre['movies']),
                      ),
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

class GenreDetailScreen extends StatelessWidget {
  final String genreName;
  final List<String> movies;

  const GenreDetailScreen({
    super.key,
    required this.genreName,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        title: Text(
          genreName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2 / 3,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                movies[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}