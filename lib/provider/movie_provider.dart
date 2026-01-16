import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/services/firestore_service.dart';

// Firestore Service Provider
final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

// Provider untuk all movies
final allMoviesProvider = StreamProvider<List<Movie>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getAllMovies();
});

// Provider untuk favorite movies
final favoriteMoviesProvider = StreamProvider<List<Movie>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getFavoriteMovies();
});

// Provider untuk trending movies
final trendingMoviesProvider = StreamProvider<List<Movie>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getMoviesByCategory('trending');
});

// Provider untuk popular movies
final popularMoviesProvider = StreamProvider<List<Movie>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getMoviesByCategory('popular');
});

// Provider untuk top rated movies
final topRatedMoviesProvider = StreamProvider<List<Movie>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getMoviesByCategory('top_rated');
});

// Provider untuk now playing movies
final nowPlayingProvider = StreamProvider<List<Movie>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getMoviesByCategory('now_playing');
});

// Provider untuk genres
final genresProvider = FutureProvider<List<Map<String, dynamic>>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getGenres();
});

// Provider untuk search query
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider untuk filtered movies berdasarkan search
final filteredMoviesProvider = StreamProvider<List<Movie>>((ref) {
  final query = ref.watch(searchQueryProvider);
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.searchMovies(query);
});

// Provider untuk selected tab di bottom navigation
final currentTabProvider = StateProvider<int>((ref) => 0);

// Provider untuk theme mode (dark/light)
final themeModeProvider = StateProvider<bool>((ref) => true); // true = dark mode

// Provider untuk movies by genre
final moviesByGenreProvider = StreamProvider.family<List<Movie>, String>((ref, genre) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getMoviesByCategory(genre.toLowerCase());
});