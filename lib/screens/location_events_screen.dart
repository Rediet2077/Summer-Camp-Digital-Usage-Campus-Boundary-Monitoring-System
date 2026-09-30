import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class LocationEventsScreen extends StatefulWidget {
  const LocationEventsScreen({super.key});

  @override
  State<LocationEventsScreen> createState() => _LocationEventsScreenState();
}

class _LocationEventsScreenState extends State<LocationEventsScreen> {
  String _selectedTab = 'All';

  final List<Map<String, dynamic>> _events = [
    {
      'type': 'Entered Camp',
      'status': 'Inside',
      'time': 'Today, 06:30 AM',
      'icon': Icons.login,
      'color': AppTheme.successColor,
    },
    {
      'type': 'Left Camp',
      'status': 'Outside',
      'time': 'Today, 09:33 PM',
      'duration': '38 minutes',
      'icon': Icons.logout,
      'color': AppTheme.errorColor,
    },
    {
      'type': 'Entered Camp',
      'status': 'Inside',
      'time': 'Today, 06:31 PM',
      'icon': Icons.login,
      'color': AppTheme.successColor,
    },
    {
      'type': 'Outside Duration',
      'status': 'Outside',
      'time': '38 minutes',
      'icon': Icons.timer,
      'color': AppTheme.warningColor,
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
          'Location Events',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          
          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildTab('All'),
                const SizedBox(width: 12),
                _buildTab('Left Camp'),
                const SizedBox(width: 12),
                _buildTab('Entered Camp'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Events List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                return _buildEventItem(_events[index], index);
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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

  Widget _buildEventItem(Map<String, dynamic> event, int index) {
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
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: event['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              event['icon'],
              color: event['color'],
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['type'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event['time'],
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
                if (event['duration'] != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.warningColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Outside Duration: ${event['duration']}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.warningColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: event['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              event['status'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: event['color'],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
