/// Navigation applicative — coquille à bottom bar et routage.
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'theme.dart';
import 'home_screen.dart';
import 'live_tv_screen.dart';
import 'movies_screen.dart';
import 'series_screen.dart';
import 'profile_screen.dart';

// ============================================================
// APP SHELL — bottom navigation à 4 destinations
// ============================================================

/// Coquille de navigation principale.
///
/// Bottom navigation à 4 destinations (Accueil / TV / Films / Séries) —
/// pas de menu hamburger. L'accès Profil se fait via l'avatar en haut
/// de l'écran Accueil, pas depuis la bottom bar, pour ne pas diluer les
/// 4 destinations de contenu avec un 5e onglet "administratif".
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  static const _screens = [
    HomeScreen(),
    LiveTvScreen(),
    MoviesScreen(),
    SeriesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.live_tv_outlined),
            selectedIcon: Icon(Icons.live_tv_rounded),
            label: 'TV',
          ),
          NavigationDestination(
            icon: Icon(Icons.movie_outlined),
            selectedIcon: Icon(Icons.movie_rounded),
            label: 'Films',
          ),
          NavigationDestination(
            icon: Icon(Icons.video_library_outlined),
            selectedIcon: Icon(Icons.video_library_rounded),
            label: 'Séries',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ROUTER
// ============================================================

/// AppShell reste monté en permanence sur '/'. Le profil est une route
/// poussée par-dessus (pas une 5e destination de la bottom bar).
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AppShell()),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
