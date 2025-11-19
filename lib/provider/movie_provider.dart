// providers/movie_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider untuk favorite movies
final favoriteMoviesProvider = StateProvider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      'title': 'Deadpool & Wolverine',
      'image': 'assets/images/deadpool.jpg',
      'genre': 'Action, Comedy',
      'year': '2024',
      'rating': 8.5,
      'isFavorite': true,
    },
    {
      'title': 'The Batman',
      'image': 'assets/images/batman.jpg',
      'genre': 'Action, Crime',
      'year': '2022',
      'rating': 8.3,
      'isFavorite': true,
    },
    {
      'title': 'Interstellar',
      'image': 'assets/images/inter.jpg',
      'genre': 'Sci-Fi, Adventure',
      'year': '2014',
      'rating': 8.6,
      'isFavorite': true,
    },
  ];
});

// Provider untuk selected tab di bottom navigation
final currentTabProvider = StateProvider<int>((ref) => 0);

// Provider untuk now playing movies
final nowPlayingProvider = FutureProvider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      'title': 'Deadpool & Wolverine',
      'image': 'assets/images/deadpool.jpg',
      'genre': 'Action, Comedy',
      'year': '2024',
      'rating': 8.5,
    },
    {
      'title': 'Avatar: The Way of Water',
      'image': 'assets/images/avatar.jpg',
      'genre': 'Sci-Fi, Adventure',
      'year': '2022',
      'rating': 7.6,
    },
    {
      'title': 'The Batman',
      'image': 'assets/images/batman.jpg',
      'genre': 'Action, Crime',
      'year': '2022',
      'rating': 8.3,
    },
  ];
});

// Provider untuk trending movies
final trendingMoviesProvider = FutureProvider<List<String>>((ref) {
  return [
    'assets/images/spiderman.jpg',
    'assets/images/inter.jpg',
    'assets/images/hp.jpg',
    'assets/images/httyd.jpg',
    'assets/images/lor.jpg',
    'assets/images/mr.jpg',
    'assets/images/deadpool.jpg',
    'assets/images/avatar.jpg',
  ];
});

// Provider untuk popular movies
final popularMoviesProvider = FutureProvider<List<String>>((ref) {
  return [
    'assets/images/httyd.jpg',
    'assets/images/narnia.jpg',
    'assets/images/pirates.jpg',
    'assets/images/batman.jpg',
    'assets/images/deadpool.jpg',
    'assets/images/mr.jpg',
  ];
});

// Provider untuk top rated movies
final topRatedMoviesProvider = FutureProvider<List<String>>((ref) {
  return [
    'assets/images/inter.jpg',
    'assets/images/hp.jpg',
    'assets/images/spiderman.jpg',
    'assets/images/hp.jpg',
    'assets/images/httyd.jpg',
    'assets/images/deadpool.jpg',
  ];
});

// Provider untuk genres
final genresProvider = FutureProvider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      'name': 'Action',
      'icon': '💥',
      'movies': [
        'assets/images/deadpool.jpg',
        'assets/images/batman.jpg',
        'assets/images/spiderman.jpg',
        'assets/images/mr.jpg',
      ]
    },
    {
      'name': 'Adventure',
      'icon': '🏔️',
      'movies': [
        'assets/images/inter.jpg',
        'assets/images/lor.jpg',
        'assets/images/narnia.jpg',
        'assets/images/pirates.jpg',
      ]
    },
    {
      'name': 'Fantasy',
      'icon': '🧙‍♂️',
      'movies': [
        'assets/images/hp.jpg',
        'assets/images/httyd.jpg',
        'assets/images/narnia.jpg',
        'assets/images/lor.jpg',
      ]
    },
    {
      'name': 'Sci-Fi',
      'icon': '🚀',
      'movies': [
        'assets/images/inter.jpg',
        'assets/images/avatar.jpg',
        'assets/images/mr.jpg',
      ]
    },
    {
      'name': 'Drama',
      'icon': '🎭',
      'movies': [
        'assets/images/mr.jpg',
        'assets/images/inter.jpg',
      ]
    },
    {
      'name': 'Comedy',
      'icon': '😂',
      'movies': [
        'assets/images/deadpool.jpg',
        'assets/images/mr.jpg',
      ]
    },
    {
      'name': 'Animation',
      'icon': '🐉',
      'movies': [
        'assets/images/httyd.jpg',
      ]
    },
  ];
});

// Provider untuk search query
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider untuk filtered movies berdasarkan search
final filteredMoviesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final query = ref.watch(searchQueryProvider);
  final allMovies = ref.watch(allMoviesProvider);
  
  if (query.isEmpty) {
    return allMovies;
  }
  
  return allMovies.where((movie) {
    return movie['title'].toLowerCase().contains(query.toLowerCase());
  }).toList();
});

// Provider untuk semua movies (gabungan dari berbagai kategori)
final allMoviesProvider = StateProvider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      'title': 'Deadpool & Wolverine',
      'image': 'assets/images/deadpool.jpg',
      'genre': 'Action, Comedy',
      'year': '2024',
      'rating': 8.5,
      'isFavorite': false,
    },
    {
      'title': 'The Batman',
      'image': 'assets/images/batman.jpg',
      'genre': 'Action, Crime',
      'year': '2022',
      'rating': 8.3,
      'isFavorite': false,
    },
    {
      'title': 'Interstellar',
      'image': 'assets/images/inter.jpg',
      'genre': 'Sci-Fi, Adventure',
      'year': '2014',
      'rating': 8.6,
      'isFavorite': false,
    },
    {
      'title': 'Harry Potter',
      'image': 'assets/images/hp.jpg',
      'genre': 'Fantasy, Adventure',
      'year': '2001',
      'rating': 8.1,
      'isFavorite': false,
    },
    {
      'title': 'Spider-Man: No Way Home',
      'image': 'assets/images/spiderman.jpg',
      'genre': 'Action, Adventure',
      'year': '2021',
      'rating': 8.2,
      'isFavorite': false,
    },
    {
      'title': 'Avatar: The Way of Water',
      'image': 'assets/images/avatar.jpg',
      'genre': 'Sci-Fi, Adventure',
      'year': '2022',
      'rating': 7.6,
      'isFavorite': false,
    },
    {
      'title': 'How to Train Your Dragon',
      'image': 'assets/images/httyd.jpg',
      'genre': 'Animation, Adventure',
      'year': '2010',
      'rating': 8.1,
      'isFavorite': false,
    },
    {
      'title': 'Lord of the Rings',
      'image': 'assets/images/lor.jpg',
      'genre': 'Fantasy, Adventure',
      'year': '2001',
      'rating': 8.8,
      'isFavorite': false,
    },
    {
      'title': 'Pirates of the Caribbean',
      'image': 'assets/images/pirates.jpg',
      'genre': 'Action, Adventure',
      'year': '2003',
      'rating': 8.0,
      'isFavorite': false,
    },
    {
      'title': 'The Chronicles of Narnia',
      'image': 'assets/images/narnia.jpg',
      'genre': 'Fantasy, Adventure',
      'year': '2005',
      'rating': 6.9,
      'isFavorite': false,
    },
    {
      'title': 'Mission: Impossible',
      'image': 'assets/images/mr.jpg',
      'genre': 'Action, Thriller',
      'year': '1996',
      'rating': 7.1,
      'isFavorite': false,
    },
  ];
});

// Provider untuk theme mode (dark/light)
final themeModeProvider = StateProvider<bool>((ref) => true); // true = dark mode
