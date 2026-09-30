import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../constants/app_theme.dart';
import '../constants/app_constants.dart';

class StudentProfileScreen extends StatefulWidget {
  final String studentId;
  final String studentName;

  const StudentProfileScreen({
    super.key,
    required this.studentId,
    required this.studentName,
  });

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: Text(
          widget.studentName,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppTheme.textPrimary),
            onPressed: () {
              // Edit student
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppTheme.textPrimary),
            onPressed: () {
              _showMoreOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Header
          _buildProfileHeader(),
          
          // Tab Bar
          TabBar(
            controller: _tabController,
            indicatorColor: AppTheme.secondaryColor,
            labelColor: AppTheme.textPrimary,
            unselectedLabelColor: AppTheme.textSecondary,
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Activity'),
              Tab(text: 'Timeline'),
            ],
          ),
          
          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildActivityTab(),
                _buildTimelineTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.secondaryColor.withOpacity(0.2),
            AppTheme.primaryColor.withOpacity(0.2),
          ],
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.secondaryColor.withOpacity(0.2),
                  border: Border.all(
                    color: AppTheme.secondaryColor,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.studentId.substring(2),
                    style: const TextStyle(
                      color: AppTheme.secondaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.successColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.darkBackground,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppTheme.textPrimary,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.studentName,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.studentId,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildHeaderBadge('Group A', Icons.group, AppTheme.secondaryColor),
                    const SizedBox(width: 8),
                    _buildHeaderBadge('Inside', Icons.location_on, AppTheme.successColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBadge(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Stats
          _buildQuickStats(),
          const SizedBox(height: 24),
          
          // Student Info
          Text(
            'Student Information',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildInfoCard(),
          const SizedBox(height: 24),
          
          // Device Info
          Text(
            'Device Information',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildDeviceCard(),
          const SizedBox(height: 24),
          
          // Recent Alerts
          Text(
            'Recent Alerts',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildRecentAlerts(),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Today\'s Usage',
            '3h 42m',
            Icons.access_time,
            AppTheme.secondaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Alerts',
            '3',
            Icons.notifications,
            AppTheme.warningColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildInfoRow(Icons.email, 'Email', 'john.doe@example.com'),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.phone, 'Phone', '+1 (555) 123-4567'),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.group, 'Camp Group', 'Group A'),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.calendar_today, 'Start Date', 'Aug 1, 2026'),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.calendar_today, 'End Date', 'Aug 30, 2026'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.textSecondary, size: 20),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.phone_android,
                  color: AppTheme.secondaryColor,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Samsung Galaxy A54',
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Android • Last seen 2m ago',
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: AppTheme.successColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildPermissionItem(Icons.location_on, 'Location', true),
              ),
              Expanded(
                child: _buildPermissionItem(Icons.apps, 'Usage', true),
              ),
              Expanded(
                child: _buildPermissionItem(Icons.notifications, 'Notifications', true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionItem(IconData icon, String label, bool granted) {
    return Column(
      children: [
        Icon(
          granted ? Icons.check_circle : Icons.cancel,
          color: granted ? AppTheme.successColor : AppTheme.errorColor,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentAlerts() {
    final alerts = [
      {
        'type': 'Excessive TikTok usage',
        'severity': AppConstants.severityMedium,
        'time': '2h ago',
      },
      {
        'type': 'Left camp boundary',
        'severity': AppConstants.severityHigh,
        'time': '5h ago',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: alerts.length,
        separatorBuilder: (context, index) => const Divider(
          color: AppTheme.textSecondary,
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
        itemBuilder: (context, index) {
          final alert = alerts[index];
          final severity = alert['severity'] as String;
          Color severityColor = severity == AppConstants.severityHigh
              ? AppTheme.errorColor
              : AppTheme.warningColor;
          
          return ListTile(
            leading: Icon(
              Icons.warning,
              color: severityColor,
            ),
            title: Text(
              alert['type'] as String,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              alert['time'] as String,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: severityColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                severity,
                style: TextStyle(
                  color: severityColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Activity',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildActivityChart(),
          const SizedBox(height: 24),
          
          Text(
            'Top Applications',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildTopApps(),
        ],
      ),
    );
  }

  Widget _buildActivityChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: [
            PieChartSectionData(
              value: 45,
              title: '45%',
              color: AppTheme.chartEducation,
              radius: 50,
            ),
            PieChartSectionData(
              value: 30,
              title: '30%',
              color: AppTheme.chartSocialMedia,
              radius: 50,
            ),
            PieChartSectionData(
              value: 25,
              title: '25%',
              color: AppTheme.chartProductivity,
              radius: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopApps() {
    final apps = [
      {'name': 'YouTube', 'time': '90 min', 'icon': Icons.play_circle, 'color': AppTheme.errorColor},
      {'name': 'Chrome', 'time': '60 min', 'icon': Icons.language, 'color': AppTheme.successColor},
      {'name': 'VS Code', 'time': '55 min', 'icon': Icons.code, 'color': AppTheme.secondaryColor},
      {'name': 'TikTok', 'time': '25 min', 'icon': Icons.music_note, 'color': AppTheme.chartSocialMedia},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: apps.length,
        separatorBuilder: (context, index) => const Divider(
          color: AppTheme.textSecondary,
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
        itemBuilder: (context, index) {
          final app = apps[index];
          return ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (app['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                app['icon'] as IconData,
                color: app['color'] as Color,
                size: 24,
              ),
            ),
            title: Text(
              app['name'] as String,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Text(
              app['time'] as String,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimelineTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTimelineItem(
          '09:10',
          'VS Code',
          'Started working on project',
          Icons.code,
          AppTheme.secondaryColor,
        ),
        _buildTimelineItem(
          '10:20',
          'YouTube',
          'Watched programming tutorial',
          Icons.play_circle,
          AppTheme.chartEducation,
        ),
        _buildTimelineItem(
          '11:15',
          'Chrome',
          'Research and documentation',
          Icons.language,
          AppTheme.successColor,
        ),
        _buildTimelineItem(
          '14:20',
          'TikTok',
          'Social media activity',
          Icons.music_note,
          AppTheme.chartSocialMedia,
        ),
        _buildTimelineItem(
          '14:32',
          'Left Camp',
          'Student left camp boundary',
          Icons.warning,
          AppTheme.errorColor,
        ),
        _buildTimelineItem(
          '15:10',
          'Returned',
          'Student returned to camp',
          Icons.check_circle,
          AppTheme.successColor,
        ),
      ],
    );
  }

  Widget _buildTimelineItem(String time, String title, String subtitle, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Container(
                width: 2,
                height: 40,
                color: color.withOpacity(0.2),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.download, color: AppTheme.secondaryColor),
                title: const Text('Export Report', style: TextStyle(color: AppTheme.textPrimary)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.message, color: AppTheme.secondaryColor),
                title: const Text('Send Message', style: TextStyle(color: AppTheme.textPrimary)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.block, color: AppTheme.errorColor),
                title: const Text('Suspend Monitoring', style: TextStyle(color: AppTheme.errorColor)),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
