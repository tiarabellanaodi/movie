import 'package:flutter/material.dart';

class MoviePosterList extends StatelessWidget {
  final List<String> items;
  final double height;

  const MoviePosterList({super.key, required this.items, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height + 12,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset( 
              items[index],
              width: 120,
              height: height,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}