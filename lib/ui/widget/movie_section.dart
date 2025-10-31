import 'package:flutter/material.dart';
import 'movie_poster_list.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<String> list;
  final double posterHeight;

  const MovieSection({
    super.key,
    required this.title,
    required this.list,
    this.posterHeight = 160,
  });

  @override
  Widget build(BuildContext context) {
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
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const Text('More',
                  style: TextStyle(fontSize: 13, color: Colors.white60)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        MoviePosterList(items: list, height: posterHeight),
      ],
    );
  }
}
