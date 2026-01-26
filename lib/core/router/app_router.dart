import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
import '../../features/pin_detail/presentation/screens/pin_detail_screen.dart';
import '../../features/create/presentation/screens/create_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/main/presentation/screens/main_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/create',
      builder: (context, state) => const CreateScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/pin/:id',
      builder: (context, state) {
        final pinId = state.pathParameters['id'] ?? '';
        return PinDetailScreen(pinId: pinId);
      },
    ),
  ],
);
