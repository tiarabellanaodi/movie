import 'package:flutter/material.dart';
import 'movie_poster_list.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<String> list;
  final double posterHeight;
  final VoidCallback? onMorePressed;

  const MovieSection({
    super.key,
    required this.title,
    required this.list,
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
        MoviePosterList(
          items: list,
          height: posterHeight,
          isResponsive: true,
        ),
      ],
    );
  }
}