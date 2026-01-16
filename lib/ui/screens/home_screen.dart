import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/provider/movie_provider.dart';
import '../widget/now_playing_section.dart';
import '../widget/movie_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingAsync = ref.watch(trendingMoviesProvider);
    final popularAsync = ref.watch(popularMoviesProvider);
    final topRatedAsync = ref.watch(topRatedMoviesProvider);
    final nowPlayingAsync = ref.watch(nowPlayingProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Now Playing Section
              nowPlayingAsync.when(
                loading: () => Container(
                  height: 300,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
                ),
                error: (error, stack) => Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Error: $error',
                        style: const TextStyle(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                data: (movies) => NowPlayingSection(movies: movies),
              ),
              const SizedBox(height: 12),

              // Trending Section
              trendingAsync.when(
                loading: () => _buildSectionLoading('Trending'),
                error: (error, stack) => _buildSectionError('Trending', error),
                data: (movies) => MovieSection(
                  title: 'Trending',
                  movies: movies,
                  posterHeight: 160,
                  onMorePressed: () {
                    context.push('/category/trending');
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Popular Section
              popularAsync.when(
                loading: () => _buildSectionLoading('Popular'),
                error: (error, stack) => _buildSectionError('Popular', error),
                data: (movies) => MovieSection(
                  title: 'Popular',
                  movies: movies,
                  posterHeight: 160,
                  onMorePressed: () {
                    context.push('/category/popular');
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Top Rated Section
              topRatedAsync.when(
                loading: () => _buildSectionLoading('Top Rated'),
                error: (error, stack) => _buildSectionError('Top Rated', error),
                data: (movies) => MovieSection(
                  title: 'Top Rated',
                  movies: movies,
                  posterHeight: 160,
                  onMorePressed: () {
                    context.push('/category/top_rated');
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLoading(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 172,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionError(String title, Object error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.error_outline, color: Colors.red, size: 16),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 100,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber, color: Colors.orange),
              const SizedBox(height: 8),
              Text(
                'Failed to load $title',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}