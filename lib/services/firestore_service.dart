import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie/models/movie.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  // Get all movies
  Stream<List<Movie>> getAllMovies() {
    return _db
        .collection('movies')
        .orderBy('order')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Movie.fromFirestore(doc.id, doc.data()))
            .toList());
  }

  // Get movies by category
  Stream<List<Movie>> getMoviesByCategory(String category) {
    return _db
        .collection('movies')
        .where('categories', arrayContains: category.toLowerCase())
        .snapshots()
        .map((snapshot) {
          final movies = snapshot.docs
              .map((doc) => Movie.fromFirestore(doc.id, doc.data()))
              .toList();
          // Sort di client-side
          movies.sort((a, b) => a.order.compareTo(b.order));
          return movies;
        });
  }

  // Get favorite movies
  Stream<List<Movie>> getFavoriteMovies() {
    return _db
        .collection('movies')
        .where('isFavorite', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
          final movies = snapshot.docs
              .map((doc) => Movie.fromFirestore(doc.id, doc.data()))
              .toList();
          // Sort di client-side
          movies.sort((a, b) => a.order.compareTo(b.order));
          return movies;
        });
  }

  // Toggle favorite status
  Future<void> toggleFavorite(String movieId, bool isFavorite) async {
    await _db.collection('movies').doc(movieId).update({
      'isFavorite': !isFavorite,
    });
  }

  // Search movies
  Stream<List<Movie>> searchMovies(String query) {
    if (query.isEmpty) {
      return getAllMovies();
    }
    
    // Note: Firestore tidak support full-text search
    // Ini adalah workaround sederhana
    return _db
        .collection('movies')
        .orderBy('title')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Movie.fromFirestore(doc.id, doc.data()))
            .where((movie) => 
                movie.title.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }

  // Add movie (untuk admin/testing)
  Future<void> addMovie(Movie movie) async {
    await _db.collection('movies').add(movie.toMap());
  }

  // Update movie
  Future<void> updateMovie(String movieId, Movie movie) async {
    await _db.collection('movies').doc(movieId).update(movie.toMap());
  }

  // Delete movie
  Future<void> deleteMovie(String movieId) async {
    await _db.collection('movies').doc(movieId).delete();
  }

  // Get genres (unique genres from all movies)
  Future<List<Map<String, dynamic>>> getGenres() async {
    final snapshot = await _db.collection('movies').get();
    final Set<String> genreSet = {};
    
    for (var doc in snapshot.docs) {
      final genre = doc.data()['genre'] as String?;
      if (genre != null) {
        // Split genre jika ada koma (e.g., "Action, Comedy")
        genreSet.addAll(genre.split(',').map((g) => g.trim()));
      }
    }

    // Icon mapping untuk setiap genre
    final Map<String, String> genreIcons = {
      'Action': '💥',
      'Adventure': '🏔️',
      'Fantasy': '🧙‍♂️',
      'Sci-Fi': '🚀',
      'Drama': '🎭',
      'Comedy': '😂',
      'Animation': '🐉',
      'Crime': '🔫',
      'Thriller': '😱',
    };

    final genreList = genreSet.map((genre) => {
      'name': genre,
      'icon': genreIcons[genre] ?? '🎬',
    }).toList();
    
    // Sort dengan casting yang aman
    genreList.sort((a, b) {
      final nameA = a['name'] as String? ?? '';
      final nameB = b['name'] as String? ?? '';
      return nameA.compareTo(nameB);
    });
    
    return genreList;
  }
}