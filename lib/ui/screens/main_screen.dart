import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; 
import 'package:movie/provider/movie_provider.dart';
import 'package:movie/ui/screens/favorite_screen.dart';
import 'package:movie/ui/screens/genre_screen.dart';
import 'package:movie/ui/screens/home_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const GenreScreen(),
    const FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentTabProvider);
    
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0F0F0F),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white54,
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(currentTabProvider.notifier).state = index;
          
          // Navigasi dengan go_router
          switch (index) {
            case 0:
              if (ModalRoute.of(context)?.settings.name != '/') {
                context.go('/');
              }
              break;
            case 1:
              // Tetap di main screen dengan tab berbeda
              break;
            case 2:
              // Tetap di main screen dengan tab berbeda
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Genre'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
      ),
    );
  }
}