import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/pin_providers.dart';
import '../widgets/pin_card.dart';
import '../../../messages/presentation/screens/messages_screen.dart';
import '../../../notifications/presentation/screens/notifications_full_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      _loadMore();
    }
  }

  void _loadMore() {
    if (!_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
        _currentPage++;
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isLoadingMore = false;
        });
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _currentPage = 1;
    });
    ref.invalidate(curatedPinsProvider(1));
  }

  @override
  Widget build(BuildContext context) {
    final pinsAsync = ref.watch(curatedPinsProvider(_currentPage));

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        title: const Text(
          'Pinterest',
          style: TextStyle(
            color: AppTheme.primaryRed,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.textPrimary),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppTheme.textPrimary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationsFullScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: AppTheme.textPrimary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MessagesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: AppTheme.primaryRed,
        child: pinsAsync.when(
          data: (pins) {
            if (pins.isEmpty) {
              return const Center(
                child: Text(
                  'No pins available',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              );
            }
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(AppConstants.gridPadding),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount: AppConstants.gridCrossAxisCount,
                    mainAxisSpacing: AppConstants.gridMainAxisSpacing,
                    crossAxisSpacing: AppConstants.gridCrossAxisSpacing,
                    itemBuilder: (context, index) {
                      if (index < pins.length) {
                        return PinCard(
                          pin: pins[index],
                          onTap: () => context.push('/pin/${pins[index].id}'),
                        );
                      } else if (_isLoadingMore) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(
                              color: AppTheme.primaryRed,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    childCount: pins.length + (_isLoadingMore ? 1 : 0),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryRed),
          ),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: AppTheme.textSecondary),
                const SizedBox(height: 16),
                Text(
                  'Error loading pins',
                  style: const TextStyle(color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _refresh,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryRed,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
