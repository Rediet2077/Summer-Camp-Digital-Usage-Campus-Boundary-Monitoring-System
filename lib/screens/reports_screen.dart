import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/app_theme.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();

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
          'Reports',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: AppTheme.textPrimary),
            onPressed: () {
              _showExportDialog();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.secondaryColor,
          labelColor: AppTheme.textPrimary,
          unselectedLabelColor: AppTheme.textSecondary,
          tabs: const [
            Tab(text: 'Daily Report'),
            Tab(text: 'Weekly Report'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDailyReport(),
          _buildWeeklyReport(),
        ],
      ),
    );
  }

  Widget _buildDailyReport() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Selector
          _buildDateSelector(),
          const SizedBox(height: 24),

          // Report Header
          _buildReportHeader('Camp Daily Digital Report', _selectedDate),
          const SizedBox(height: 24),

          // Summary Stats
          _buildSummaryStats(),
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
          _buildCategoryChart(),
          const SizedBox(height: 24),

          // Boundary Events
          Text(
            'Boundary Events',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildBoundaryEvents(),
          const SizedBox(height: 24),

          // Alerts Summary
          Text(
            'Alerts Summary',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildAlertsSection(),
        ],
      ),
    );
  }

  Widget _buildWeeklyReport() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Week Selector
          _buildWeekSelector(),
          const SizedBox(height: 24),

          // Report Header
          _buildReportHeader('Camp Weekly Report', _selectedDate),
          const SizedBox(height: 24),

          // Weekly Trend
          Text(
            'Weekly Usage Trend',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildWeeklyTrendChart(),
          const SizedBox(height: 24),

          // Top Applications
          Text(
            'Top Applications',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildTopApplications(),
          const SizedBox(height: 24),

          // Weekly Summary
          Text(
            'Weekly Summary',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildWeeklySummary(),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: AppTheme.textPrimary),
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.subtract(const Duration(days: 1));
              });
            },
          ),
          Text(
            DateFormat('MMMM dd, yyyy').format(_selectedDate),
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: AppTheme.textPrimary),
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.add(const Duration(days: 1));
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeekSelector() {
    final weekStart = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: AppTheme.textPrimary),
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.subtract(const Duration(days: 7));
              });
            },
          ),
          Text(
            '${DateFormat('MMM dd').format(weekStart)} - ${DateFormat('MMM dd, yyyy').format(weekEnd)}',
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: AppTheme.textPrimary),
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.add(const Duration(days: 7));
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReportHeader(String title, DateTime date) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.secondaryColor.withOpacity(0.8),
            AppTheme.primaryColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.assessment,
                color: AppTheme.textPrimary,
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Generated on ${DateFormat('MMM dd, yyyy HH:mm').format(DateTime.now())}',
            style: TextStyle(
              color: AppTheme.textPrimary.withOpacity(0.9),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Total Students', '250', Icons.people),
              ),
              Expanded(
                child: _buildStatItem('Active Devices', '235', Icons.phone_android),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Inside Camp', '247', Icons.check_circle),
              ),
              Expanded(
                child: _buildStatItem('Outside Camp', '3', Icons.warning),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.darkBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.secondaryColor, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 50,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const categories = ['Edu', 'Prod', 'Social', 'Ent', 'Game'];
                        if (value.toInt() < categories.length) {
                          return Text(
                            categories[value.toInt()],
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 11,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}%',
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 11,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [
                    BarChartRodData(toY: 45, color: AppTheme.chartEducation, width: 20),
                  ]),
                  BarChartGroupData(x: 1, barRods: [
                    BarChartRodData(toY: 25, color: AppTheme.chartProductivity, width: 20),
                  ]),
                  BarChartGroupData(x: 2, barRods: [
                    BarChartRodData(toY: 15, color: AppTheme.chartSocialMedia, width: 20),
                  ]),
                  BarChartGroupData(x: 3, barRods: [
                    BarChartRodData(toY: 10, color: AppTheme.chartEntertainment, width: 20),
                  ]),
                  BarChartGroupData(x: 4, barRods: [
                    BarChartRodData(toY: 5, color: AppTheme.chartGaming, width: 20),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoundaryEvents() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildBoundaryEventRow('Students Leaving Camp', '3', Icons.logout, AppTheme.errorColor),
          const Divider(color: AppTheme.textSecondary, height: 24),
          _buildBoundaryEventRow('Total Outside Duration', '95 min', Icons.timelapse, AppTheme.warningColor),
          const Divider(color: AppTheme.textSecondary, height: 24),
          _buildBoundaryEventRow('Average Outside Time', '32 min', Icons.access_time, AppTheme.infoColor),
        ],
      ),
    );
  }

  Widget _buildBoundaryEventRow(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAlertsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildAlertRow('Critical', 2, AppTheme.errorColor),
          const SizedBox(height: 12),
          _buildAlertRow('High', 5, AppTheme.warningColor),
          const SizedBox(height: 12),
          _buildAlertRow('Medium', 12, AppTheme.infoColor),
          const SizedBox(height: 12),
          _buildAlertRow('Low', 8, AppTheme.textSecondary),
        ],
      ),
    );
  }

  Widget _buildAlertRow(String severity, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            severity,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          count.toString(),
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyTrendChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: AppTheme.textSecondary.withOpacity(0.1),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  if (value.toInt() < days.length) {
                    return Text(
                      days[value.toInt()],
                      style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}h',
                    style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 3),
                FlSpot(1, 4),
                FlSpot(2, 3.5),
                FlSpot(3, 5),
                FlSpot(4, 4),
                FlSpot(5, 4.5),
                FlSpot(6, 3.5),
              ],
              isCurved: true,
              color: AppTheme.secondaryColor,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: AppTheme.secondaryColor.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopApplications() {
    final apps = [
      {'name': 'YouTube', 'time': '8h 30m'},
      {'name': 'VS Code', 'time': '6h 45m'},
      {'name': 'Chrome', 'time': '5h 20m'},
      {'name': 'Instagram', 'time': '3h 15m'},
      {'name': 'Spotify', 'time': '2h 40m'},
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
            leading: CircleAvatar(
              backgroundColor: AppTheme.secondaryColor.withOpacity(0.1),
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
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

  Widget _buildWeeklySummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('Total Usage', '26h 15m'),
          const SizedBox(height: 12),
          _buildSummaryRow('Daily Average', '3h 45m'),
          const SizedBox(height: 12),
          _buildSummaryRow('Most Active Day', 'Thursday'),
          const SizedBox(height: 12),
          _buildSummaryRow('Boundary Violations', '7'),
          const SizedBox(height: 12),
          _buildSummaryRow('Total Alerts', '27'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showExportDialog() {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Export Report',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: AppTheme.errorColor),
                title: const Text(
                  'Export as PDF',
                  style: TextStyle(color: AppTheme.textPrimary),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Exporting as PDF...')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.table_chart, color: AppTheme.successColor),
                title: const Text(
                  'Export as CSV',
                  style: TextStyle(color: AppTheme.textPrimary),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Exporting as CSV...')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.email, color: AppTheme.secondaryColor),
                title: const Text(
                  'Send via Email',
                  style: TextStyle(color: AppTheme.textPrimary),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening email...')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
