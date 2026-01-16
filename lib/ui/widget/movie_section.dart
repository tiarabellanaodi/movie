import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'movie_poster_card.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final double posterHeight;
  final VoidCallback? onMorePressed;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    this.posterHeight = 160,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              if (onMorePressed != null)
                GestureDetector(
                  onTap: onMorePressed,
                  child: Row(
                    children: const [
                      Text(
                        'More',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white60,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Colors.white60,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: posterHeight + 12,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return MoviePosterCard(
                movie: movies[index],
                height: posterHeight,
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}