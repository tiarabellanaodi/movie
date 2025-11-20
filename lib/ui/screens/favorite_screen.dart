import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/provider/movie_provider.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider);
    
    return Scaffold(
      body: SafeArea(
        child: Column(
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
              child: Text(
                'FAVORITE MOVIES (${favoriteMovies.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final favorites = ref.watch(favoriteMoviesProvider);
                  
                  return ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final movie = favorites[index];
                      return Card(
                        child: ListTile(
                          leading: Image.asset(movie['image'], width: 50, height: 70, fit: BoxFit.cover),
                          title: Text(movie['title']),
                          subtitle: Text('${movie['genre']} • ${movie['year']}'),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: movie['isFavorite'] ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              ref.read(favoriteMoviesProvider.notifier).state = 
                                  List.from(favorites)..removeAt(index);
                            },
                          ),
                        ),
                      );
                    },
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