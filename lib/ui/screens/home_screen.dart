import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';  // TAMBAH IMPORT
import 'package:movie/provider/movie_provider.dart';
import '../widget/now_playing_section.dart';
import '../widget/movie_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trending = ref.watch(trendingMoviesProvider);
    final popular = ref.watch(popularMoviesProvider);
    final topRated = ref.watch(topRatedMoviesProvider);
    final nowPlaying = ref.watch(nowPlayingProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Now Playing Section
              Consumer(
                builder: (context, ref, child) {
                  final nowPlayingState = ref.watch(nowPlayingProvider);
                  return nowPlayingState.when(
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
                  );
                },
              ),
              const SizedBox(height: 12),

              // Trending Section
              Consumer(
                builder: (context, ref, child) {
                  final trendingState = ref.watch(trendingMoviesProvider);
                  return trendingState.when(
                    loading: () => _buildSectionLoading('Trending'),
                    error: (error, stack) => _buildSectionError('Trending', error),
                    data: (movies) => MovieSection(
                      title: 'Trending',
                      list: movies,
                      posterHeight: 160,
                      onMorePressed: () {
                        // Navigasi ke halaman category dengan go_router
                        context.push('/category/trending');
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Popular Section
              Consumer(
                builder: (context, ref, child) {
                  final popularState = ref.watch(popularMoviesProvider);
                  return popularState.when(
                    loading: () => _buildSectionLoading('Popular'),
                    error: (error, stack) => _buildSectionError('Popular', error),
                    data: (movies) => MovieSection(
                      title: 'Popular',
                      list: movies,
                      posterHeight: 160,
                      onMorePressed: () {
                        // Navigasi ke halaman category dengan go_router
                        context.push('/category/popular');
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Top Rated Section
              Consumer(
                builder: (context, ref, child) {
                  final topRatedState = ref.watch(topRatedMoviesProvider);
                  return topRatedState.when(
                    loading: () => _buildSectionLoading('Top Rated'),
                    error: (error, stack) => _buildSectionError('Top Rated', error),
                    data: (movies) => MovieSection(
                      title: 'Top Rated',
                      list: movies,
                      posterHeight: 160,
                      onMorePressed: () {
                        // Navigasi ke halaman category dengan go_router
                        context.push('/category/top_rated');
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi _buildSectionLoading dan _buildSectionError tetap sama
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