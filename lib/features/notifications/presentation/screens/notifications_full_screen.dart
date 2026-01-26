import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class NotificationsFullScreen extends StatelessWidget {
  const NotificationsFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Updates',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: TabBar(
            labelColor: AppTheme.textPrimary,
            unselectedLabelColor: AppTheme.textSecondary,
            indicatorColor: AppTheme.primaryRed,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Following'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildNotificationsList(),
            _buildFollowingList(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader('Today'),
        _buildNotificationTile(
          icon: Icons.favorite,
          iconColor: AppTheme.primaryRed,
          title: 'Your pin got 50 new likes!',
          subtitle: 'Nature Photography board',
          time: '2h ago',
          imageUrl: 'https://picsum.photos/seed/notif1/100/100',
        ),
        _buildNotificationTile(
          icon: Icons.person_add,
          iconColor: Colors.blue,
          title: 'Design Studio started following you',
          subtitle: 'New follower',
          time: '4h ago',
        ),
        _buildSectionHeader('Yesterday'),
        _buildNotificationTile(
          icon: Icons.bookmark,
          iconColor: Colors.green,
          title: 'Your pin was saved 25 times',
          subtitle: 'Home Decor ideas',
          time: '1d ago',
          imageUrl: 'https://picsum.photos/seed/notif2/100/100',
        ),
        _buildNotificationTile(
          icon: Icons.comment,
          iconColor: Colors.orange,
          title: 'New comment on your pin',
          subtitle: '"This is amazing!"',
          time: '1d ago',
          imageUrl: 'https://picsum.photos/seed/notif3/100/100',
        ),
        _buildSectionHeader('This Week'),
        _buildNotificationTile(
          icon: Icons.trending_up,
          iconColor: AppTheme.primaryRed,
          title: 'Your pins are trending!',
          subtitle: '1.2K people viewed your pins',
          time: '3d ago',
        ),
        _buildNotificationTile(
          icon: Icons.lightbulb,
          iconColor: Colors.amber,
          title: 'Ideas for you',
          subtitle: 'Based on your recent activity',
          time: '5d ago',
        ),
      ],
    );
  }

  Widget _buildFollowingList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFollowingTile(
          name: 'Design Ideas',
          action: 'saved 5 new pins',
          time: '1h ago',
        ),
        _buildFollowingTile(
          name: 'Home Decor',
          action: 'created a new board',
          time: '3h ago',
        ),
        _buildFollowingTile(
          name: 'Fashion Weekly',
          action: 'saved 12 new pins',
          time: '1d ago',
        ),
        _buildFollowingTile(
          name: 'Travel Guide',
          action: 'updated their profile',
          time: '2d ago',
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
    String? imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, color: AppTheme.textSecondary),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFollowingTile({
    required String name,
    required String action,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppTheme.primaryRed,
            child: Text(
              name[0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: ' $action',
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
