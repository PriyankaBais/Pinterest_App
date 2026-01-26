import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Messages',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppTheme.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('New message feature coming soon')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(22),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search messages',
                  hintStyle: TextStyle(color: AppTheme.textSecondary),
                  prefixIcon: Icon(Icons.search, color: AppTheme.textSecondary),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          // Messages list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildMessageTile(
                  name: 'Pinterest',
                  message: 'Welcome to Pinterest! Start exploring...',
                  time: '2h',
                  isRead: false,
                  avatar: Icons.push_pin,
                ),
                _buildMessageTile(
                  name: 'Design Ideas',
                  message: 'Check out these new design trends',
                  time: '1d',
                  isRead: true,
                  avatar: Icons.design_services,
                ),
                _buildMessageTile(
                  name: 'Home Decor',
                  message: 'Your saved pins are getting popular!',
                  time: '3d',
                  isRead: true,
                  avatar: Icons.home,
                ),
                _buildMessageTile(
                  name: 'Fashion Weekly',
                  message: 'New fashion ideas just for you',
                  time: '1w',
                  isRead: true,
                  avatar: Icons.checkroom,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageTile({
    required String name,
    required String message,
    required String time,
    required bool isRead,
    required IconData avatar,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: AppTheme.primaryRed,
        child: Icon(avatar, color: Colors.white, size: 24),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                color: AppTheme.textPrimary,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: isRead ? AppTheme.textSecondary : AppTheme.primaryRed,
              fontSize: 12,
            ),
          ),
        ],
      ),
      subtitle: Text(
        message,
        style: TextStyle(
          color: isRead ? AppTheme.textSecondary : AppTheme.textPrimary,
          fontWeight: isRead ? FontWeight.normal : FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: !isRead
          ? Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: AppTheme.primaryRed,
                shape: BoxShape.circle,
              ),
            )
          : null,
      onTap: () {},
    );
  }
}
