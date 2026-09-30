import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/app_theme.dart';
import '../widgets/stat_card.dart';
import 'students_list_screen.dart';
import 'device_registration_screen.dart';
import 'usage_analytics_screen.dart';
import 'camp_boundary_screen.dart';
import 'location_events_screen.dart';
import 'alerts_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppTheme.textPrimary),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good morning, John!',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Here's today's summary",
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppTheme.textPrimary),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppTheme.secondaryColor,
              child: const Text(
                'JD',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Total Students',
                    value: '250',
                    icon: Icons.people,
                    iconColor: AppTheme.secondaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    title: 'Active Devices',
                    value: '235',
                    icon: Icons.phone_android,
                    iconColor: AppTheme.successColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Students Inside',
                    value: '247',
                    icon: Icons.location_on,
                    iconColor: AppTheme.successColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    title: 'Students Outside',
                    value: '3',
                    icon: Icons.warning,
                    iconColor: AppTheme.errorColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Usage by Category
            Text(
              'Usage by Category',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildUsagePieChart(),
            const SizedBox(height: 24),

            // Most Used Applications
            Text(
              'Most Used Applications',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildApplicationsList(),
            const SizedBox(height: 24),

            // Recent Apps
            Text(
              'Recent Apps',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildRecentApps(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppTheme.cardBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppTheme.textPrimary,
                  child: const Text(
                    'JD',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'john.doe@example.com',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.dashboard, 'Dashboard', () {
            Navigator.pop(context);
          }),
          _buildDrawerItem(Icons.people, 'Students', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StudentsListScreen()),
            );
          }),
          _buildDrawerItem(Icons.phone_android, 'Devices', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DeviceRegistrationScreen()),
            );
          }),
          _buildDrawerItem(Icons.analytics, 'Analytics', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UsageAnalyticsScreen()),
            );
          }),
          _buildDrawerItem(Icons.map, 'Geofence', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CampBoundaryScreen()),
            );
          }),
          _buildDrawerItem(Icons.location_on, 'Location', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LocationEventsScreen()),
            );
          }),
          _buildDrawerItem(Icons.notifications, 'Alerts', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AlertsScreen()),
            );
          }),
          _buildDrawerItem(Icons.assessment, 'Reports', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReportsScreen()),
            );
          }),
          const Divider(color: AppTheme.textSecondary),
          _buildDrawerItem(Icons.settings, 'Settings', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          }),
          _buildDrawerItem(Icons.logout, 'Logout', () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: AppTheme.cardBackground,
                title: const Text(
                  'Logout',
                  style: TextStyle(color: AppTheme.textPrimary),
                ),
                content: const Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.errorColor,
                    ),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.textSecondary),
      title: Text(
        title,
        style: const TextStyle(color: AppTheme.textPrimary),
      ),
      onTap: onTap,
    );
  }

  Widget _buildUsagePieChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
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
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  PieChartSectionData(
                    value: 25,
                    title: '25%',
                    color: AppTheme.chartProductivity,
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  PieChartSectionData(
                    value: 15,
                    title: '15%',
                    color: AppTheme.chartSocialMedia,
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  PieChartSectionData(
                    value: 10,
                    title: '10%',
                    color: AppTheme.chartEntertainment,
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  PieChartSectionData(
                    value: 5,
                    title: '5%',
                    color: AppTheme.chartGaming,
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('Education', AppTheme.chartEducation, '45%'),
                _buildLegendItem('Productivity', AppTheme.chartProductivity, '25%'),
                _buildLegendItem('Social Media', AppTheme.chartSocialMedia, '15%'),
                _buildLegendItem('Entertainment', AppTheme.chartEntertainment, '10%'),
                _buildLegendItem('Gaming', AppTheme.chartGaming, '5%'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, String percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 11,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationsList() {
    final apps = [
      {'name': 'YouTube', 'time': '2h 30m', 'icon': Icons.play_circle, 'color': AppTheme.errorColor},
      {'name': 'VS Code', 'time': '1h 45m', 'icon': Icons.code, 'color': AppTheme.secondaryColor},
      {'name': 'Chrome', 'time': '1h 20m', 'icon': Icons.language, 'color': AppTheme.successColor},
      {'name': 'Instagram', 'time': '45m', 'icon': Icons.photo_camera, 'color': AppTheme.chartSocialMedia},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
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

  Widget _buildRecentApps() {
    final recentApps = [
      {'name': 'GitHub', 'time': '2m ago', 'icon': Icons.code_rounded, 'color': AppTheme.textPrimary},
      {'name': 'Slack', 'time': '15m ago', 'icon': Icons.chat, 'color': AppTheme.chartProductivity},
      {'name': 'Spotify', 'time': '1h ago', 'icon': Icons.music_note, 'color': AppTheme.successColor},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recentApps.length,
        separatorBuilder: (context, index) => const Divider(
          color: AppTheme.textSecondary,
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
        itemBuilder: (context, index) {
          final app = recentApps[index];
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
                size: 20,
              ),
            ),
            title: Text(
              app['name'] as String,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              app['time'] as String,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Active',
                style: TextStyle(
                  color: AppTheme.successColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: AppTheme.cardBackground,
        selectedItemColor: AppTheme.secondaryColor,
        unselectedItemColor: AppTheme.textSecondary,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          
          // Navigate based on selected index
          switch (index) {
            case 0:
              // Dashboard - already here
              break;
            case 1:
              // Analytics
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UsageAnalyticsScreen()),
              );
              break;
            case 2:
              // Alerts
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AlertsScreen()),
              );
              break;
            case 3:
              // Profile/Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
