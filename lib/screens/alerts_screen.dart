import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String _selectedTab = 'All';

  final List<Map<String, dynamic>> _notifications = [
    {
      'type': 'Location',
      'title': 'You are inside camp',
      'message': 'You entered the camp at 06:30 AM',
      'time': '1 minute ago',
      'icon': Icons.location_on,
      'color': AppTheme.successColor,
      'bgColor': AppTheme.successColor,
    },
    {
      'type': 'Usage',
      'title': '131% usage exceeded 2D minutes',
      'message': 'Your daily screen time limit has been exceeded',
      'time': '35 minutes ago',
      'icon': Icons.warning,
      'color': AppTheme.warningColor,
      'bgColor': AppTheme.warningColor,
    },
    {
      'type': 'System',
      'title': 'Low education recommendation',
      'message': 'Consider spending more time on educational content',
      'time': '1 hour ago',
      'icon': Icons.lightbulb_outline,
      'color': AppTheme.infoColor,
      'bgColor': AppTheme.infoColor,
    },
    {
      'type': 'System',
      'title': 'Device battery low',
      'message': 'Your device battery is below 20%',
      'time': '2 hours ago',
      'icon': Icons.battery_alert,
      'color': AppTheme.errorColor,
      'bgColor': AppTheme.errorColor,
    },
    {
      'type': 'System',
      'title': 'Weekly report ready',
      'message': 'Your weekly usage report is now available',
      'time': '1 day ago',
      'icon': Icons.description,
      'color': AppTheme.chartProductivity,
      'bgColor': AppTheme.chartProductivity,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
            },
            child: const Text(
              'Mark all read',
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          
          // Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildTab('All'),
                const SizedBox(width: 12),
                _buildTab('Usage'),
                const SizedBox(width: 12),
                _buildTab('Location'),
                const SizedBox(width: 12),
                _buildTab('System'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Notifications List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationItem(_notifications[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title) {
    final isSelected = _selectedTab == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: notification['bgColor'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              notification['icon'],
              color: notification['color'],
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['title'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification['message'],
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  notification['time'],
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          
          // More options
          IconButton(
            icon: const Icon(Icons.more_vert, size: 20),
            color: AppTheme.textSecondary,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              // Show options
            },
          ),
        ],
      ),
    );
  }
}
