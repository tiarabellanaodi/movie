import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NowPlayingSection extends ConsumerStatefulWidget {
  final List<Map<String, dynamic>> movies;

  const NowPlayingSection({super.key, required this.movies});

  @override
  ConsumerState<NowPlayingSection> createState() => _NowPlayingSectionState();
}

class _NowPlayingSectionState extends ConsumerState<NowPlayingSection> {
  final PageController _controller = PageController(viewportFraction: 0.86);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _currentIndex = _controller.page?.round() ?? 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final carouselHeight = screenHeight * 0.5; // Responsive height

    return Column(
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
          child: const Text(
            'Now Playing',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),

        // Carousel
        SizedBox(
          height: carouselHeight,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              final item = widget.movies[index];
              final isActive = index == _currentIndex;
              
              return AnimatedScale(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                scale: isActive ? 1.0 : 0.92,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          // Movie Image
                          Image.asset(
                            item['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),

                          // Gradient Overlay
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.3),
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),

                          // Movie Info
                          Positioned(
                            left: 16,
                            bottom: 16,
                            right: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${item['genre'] ?? 'Action'} | ${item['year'] ?? '2024'}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      item['rating']?.toString() ?? '8.0',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Play Button
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: FloatingActionButton.small(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black,
                              onPressed: () {
                                // Handle play action
                              },
                              child: const Icon(Icons.play_arrow),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Page Indicators
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.movies.length,
            (index) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index 
                    ? Colors.amber 
                    : Colors.white.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}