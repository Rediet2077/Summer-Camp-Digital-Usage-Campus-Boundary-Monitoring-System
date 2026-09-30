import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/app_theme.dart';
import '../constants/app_constants.dart';

class LocationEventsScreen extends StatefulWidget {
  const LocationEventsScreen({super.key});

  @override
  State<LocationEventsScreen> createState() => _LocationEventsScreenState();
}

class _LocationEventsScreenState extends State<LocationEventsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Left Camp', 'Returned', 'Today'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Location Events',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.textPrimary),
            onPressed: () {
              // Show search
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.secondaryColor,
          labelColor: AppTheme.textPrimary,
          unselectedLabelColor: AppTheme.textSecondary,
          tabs: const [
            Tab(text: 'Recent Events'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Bar
          _buildFilterBar(),
          
          // Tab View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRecentEventsTab(),
                _buildHistoryTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppTheme.cardBackground,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filterOptions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = _filterOptions[index];
          final isSelected = filter == _selectedFilter;
          
          return FilterChip(
            label: Text(filter),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                _selectedFilter = filter;
              });
            },
            selectedColor: AppTheme.secondaryColor,
            backgroundColor: AppTheme.darkBackground,
            labelStyle: TextStyle(
              color: isSelected ? AppTheme.textPrimary : AppTheme.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
            side: BorderSide(
              color: isSelected ? AppTheme.secondaryColor : AppTheme.textSecondary.withOpacity(0.3),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentEventsTab() {
    final events = [
      {
        'student': 'ST023',
        'name': 'John Doe',
        'event': AppConstants.eventLeftCamp,
        'time': DateTime.now().subtract(const Duration(minutes: 30)),
        'duration': null,
        'status': 'ongoing',
      },
      {
        'student': 'ST041',
        'name': 'Jane Smith',
        'event': AppConstants.eventLeftCamp,
        'time': DateTime.now().subtract(const Duration(hours: 1, minutes: 15)),
        'duration': const Duration(minutes: 38),
        'status': 'completed',
      },
      {
        'student': 'ST041',
        'name': 'Jane Smith',
        'event': AppConstants.eventEnteredCamp,
        'time': DateTime.now().subtract(const Duration(minutes: 37)),
        'duration': null,
        'status': 'completed',
      },
      {
        'student': 'ST014',
        'name': 'Mike Johnson',
        'event': AppConstants.eventLeftCamp,
        'time': DateTime.now().subtract(const Duration(hours: 2, minutes: 45)),
        'duration': const Duration(minutes: 22),
        'status': 'completed',
      },
      {
        'student': 'ST014',
        'name': 'Mike Johnson',
        'event': AppConstants.eventEnteredCamp,
        'time': DateTime.now().subtract(const Duration(hours: 2, minutes: 23)),
        'duration': null,
        'status': 'completed',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return _buildEventCard(event);
      },
    );
  }

  Widget _buildHistoryTab() {
    // Group events by date
    final groupedEvents = {
      'Today': [
        {
          'student': 'ST023',
          'name': 'John Doe',
          'leftTime': '14:32',
          'returnedTime': null,
          'duration': 'Ongoing',
          'status': 'outside',
        },
        {
          'student': 'ST041',
          'name': 'Jane Smith',
          'leftTime': '13:15',
          'returnedTime': '13:53',
          'duration': '38 min',
          'status': 'returned',
        },
      ],
      'Yesterday': [
        {
          'student': 'ST027',
          'name': 'Sarah Wilson',
          'leftTime': '15:20',
          'returnedTime': '15:35',
          'duration': '15 min',
          'status': 'returned',
        },
        {
          'student': 'ST006',
          'name': 'Tom Brown',
          'leftTime': '10:45',
          'returnedTime': '11:30',
          'duration': '45 min',
          'status': 'returned',
        },
      ],
      'This Week': [
        {
          'student': 'ST012',
          'name': 'Emily Davis',
          'leftTime': 'Mon 14:00',
          'returnedTime': 'Mon 14:25',
          'duration': '25 min',
          'status': 'returned',
        },
      ],
    };

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groupedEvents.length,
      itemBuilder: (context, index) {
        final date = groupedEvents.keys.elementAt(index);
        final events = groupedEvents[date]!;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                date,
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...events.map((event) => _buildHistoryCard(event)).toList(),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    final isLeftEvent = event['event'] == AppConstants.eventLeftCamp;
    final isOngoing = event['status'] == 'ongoing';
    final time = event['time'] as DateTime;
    final duration = event['duration'] as Duration?;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isOngoing
              ? AppTheme.errorColor.withOpacity(0.3)
              : AppTheme.textSecondary.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Student Avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: isLeftEvent
                    ? AppTheme.errorColor.withOpacity(0.2)
                    : AppTheme.successColor.withOpacity(0.2),
                child: Text(
                  (event['student'] as String).substring(2),
                  style: TextStyle(
                    color: isLeftEvent ? AppTheme.errorColor : AppTheme.successColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Student Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['name'] as String,
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      event['student'] as String,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isLeftEvent
                      ? AppTheme.errorColor.withOpacity(0.1)
                      : AppTheme.successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isLeftEvent ? Icons.logout : Icons.login,
                      color: isLeftEvent ? AppTheme.errorColor : AppTheme.successColor,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isLeftEvent ? 'Left' : 'Returned',
                      style: TextStyle(
                        color: isLeftEvent ? AppTheme.errorColor : AppTheme.successColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Event Details
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.darkBackground.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildEventDetail(
                    Icons.access_time,
                    'Time',
                    DateFormat('HH:mm').format(time),
                  ),
                ),
                if (duration != null)
                  Expanded(
                    child: _buildEventDetail(
                      Icons.timelapse,
                      'Duration',
                      '${duration.inMinutes} min',
                    ),
                  ),
                if (isOngoing)
                  Expanded(
                    child: _buildEventDetail(
                      Icons.error_outline,
                      'Status',
                      'Ongoing',
                      color: AppTheme.warningColor,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetail(IconData icon, String label, String value, {Color? color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color ?? AppTheme.textSecondary,
          size: 16,
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 11,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: color ?? AppTheme.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> event) {
    final isOutside = event['status'] == 'outside';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Student Info
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['name'] as String,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  event['student'] as String,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          // Left Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Left',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                  ),
                ),
                Text(
                  event['leftTime'] as String,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          // Returned Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Returned',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                  ),
                ),
                Text(
                  event['returnedTime'] as String? ?? '--',
                  style: TextStyle(
                    color: isOutside ? AppTheme.errorColor : AppTheme.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          // Duration
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isOutside
                  ? AppTheme.errorColor.withOpacity(0.1)
                  : AppTheme.successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              event['duration'] as String,
              style: TextStyle(
                color: isOutside ? AppTheme.errorColor : AppTheme.successColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
