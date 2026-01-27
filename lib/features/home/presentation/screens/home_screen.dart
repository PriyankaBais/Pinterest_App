import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/pin_providers.dart';
import '../widgets/pin_card.dart';
import '../widgets/pin_shimmer_card.dart';
import '../../../messages/presentation/screens/messages_screen.dart';
import '../../../notifications/presentation/screens/notifications_full_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

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
      ref.read(curatedFeedProvider.notifier).loadMore();
    }
  }

  Future<void> _refresh() async {
    await ref.read(curatedFeedProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(curatedFeedProvider);

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
        child: Builder(
          builder: (context) {
            if (feedState.isLoadingInitial) {
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
                        final height = 180 + (index % 5) * 70.0;
                        return PinShimmerCard(height: height);
                      },
                      childCount: 12,
                    ),
                  ),
                ],
              );
            }

            if (feedState.error != null && feedState.pins.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: AppTheme.textSecondary),
                    const SizedBox(height: 16),
                    const Text(
                      'Error loading pins',
                      style: TextStyle(color: AppTheme.textSecondary),
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
              );
            }

            if (feedState.pins.isEmpty) {
              return const Center(
                child: Text(
                  'No pins available',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              );
            }

            final pins = feedState.pins;
            final shimmerTailCount = feedState.isLoadingMore ? 6 : 0;

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
                      }

                      final shimmerIndex = index - pins.length;
                      final height = 160 + (shimmerIndex % 5) * 70.0;
                      return PinShimmerCard(height: height);
                    },
                    childCount: pins.length + shimmerTailCount,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
