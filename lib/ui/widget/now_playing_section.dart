import 'package:flutter/material.dart';

class NowPlayingSection extends StatefulWidget {
  const NowPlayingSection({super.key});

  @override
  State<NowPlayingSection> createState() => _NowPlayingSectionState();
}

class _NowPlayingSectionState extends State<NowPlayingSection> {
  final PageController _controller = PageController(viewportFraction: 0.86);
  int _index = 0;

  final List<Map<String, String>> nowPlaying = [
    {
      'title': 'Deadpool & Wolverine',
      'image': 'assets/images/deadpool.jpg',
    },
    {
      'title': 'Avatar',
      'image': 'assets/images/avatar.jpg',
    },
    {
      'title': 'The Batman',
      'image': 'assets/images/batman.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _index = _controller.page?.round() ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),


        AspectRatio(
          aspectRatio: 27 / 40, 
          child: PageView.builder(
            controller: _controller,
            itemCount: nowPlaying.length,
            itemBuilder: (context, i) {
              final item = nowPlaying[i];
              final active = i == _index;
              return AnimatedScale(
                duration: const Duration(milliseconds: 250),
                scale: active ? 1.0 : 0.94,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          item['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),

                      Positioned(
                        left: 14,
                        bottom: 16,
                        right: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Action | 2024',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        right: 18,
                        bottom: 18,
                        child: Material(
                          shape: const CircleBorder(),
                          color: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.chevron_right),
                            color: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
