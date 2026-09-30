import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/app_theme.dart';
import '../constants/app_constants.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String _selectedSeverity = 'All';
  final List<String> _severityOptions = ['All', 'Critical', 'High', 'Medium', 'Low'];

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
          'Alerts',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppTheme.textPrimary),
            onPressed: () {
              // Show alert settings
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Cards
          _buildSummaryCards(),
          
          // Filter Bar
          _buildFilterBar(),
          
          // Alerts List
          Expanded(
            child: _buildAlertsList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMarkAllAsReadDialog();
        },
        backgroundColor: AppTheme.secondaryColor,
        child: const Icon(Icons.done_all),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'Critical',
              '2',
              AppTheme.errorColor,
              Icons.error,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard(
              'High',
              '5',
              AppTheme.warningColor,
              Icons.warning,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard(
              'Medium',
              '12',
              AppTheme.infoColor,
              Icons.info,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard(
              'Low',
              '8',
              AppTheme.textSecondary,
              Icons.notifications,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String label, String count, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(
            count,
            style: TextStyle(
              color: color,
              fontSize: 18,
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
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppTheme.cardBackground,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _severityOptions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final severity = _severityOptions[index];
          final isSelected = severity == _selectedSeverity;
          
          return FilterChip(
            label: Text(severity),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                _selectedSeverity = severity;
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

  Widget _buildAlertsList() {
    final alerts = [
      {
        'type': AppConstants.alertLeftCamp,
        'student': 'ST023',
        'name': 'John Doe',
        'severity': AppConstants.severityHigh,
        'time': DateTime.now().subtract(const Duration(minutes: 30)),
        'message': 'Student left camp boundary',
        'status': 'Open',
      },
      {
        'type': AppConstants.alertExcessiveSocialMedia,
        'student': 'ST014',
        'name': 'Jane Smith',
        'severity': AppConstants.severityMedium,
        'time': DateTime.now().subtract(const Duration(hours: 1)),
        'message': 'Excessive TikTok usage: 48 min (allowed: 20 min)',
        'status': 'Open',
      },
      {
        'type': AppConstants.alertExcessiveEntertainment,
        'student': 'ST027',
        'name': 'Mike Johnson',
        'severity': AppConstants.severityMedium,
        'time': DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
        'message': 'Excessive YouTube Shorts: 35 min (allowed: 15 min)',
        'status': 'Open',
      },
      {
        'type': AppConstants.alertDeviceOffline,
        'student': 'ST006',
        'name': 'Sarah Wilson',
        'severity': AppConstants.severityLow,
        'time': DateTime.now().subtract(const Duration(hours: 2)),
        'message': 'Device has been offline for 2 hours',
        'status': 'Open',
      },
      {
        'type': AppConstants.alertRestrictedApp,
        'student': 'ST041',
        'name': 'Tom Brown',
        'severity': AppConstants.severityHigh,
        'time': DateTime.now().subtract(const Duration(hours: 3)),
        'message': 'Restricted application detected: Gaming App',
        'status': 'Resolved',
      },
      {
        'type': AppConstants.alertLeftCamp,
        'student': 'ST012',
        'name': 'Emily Davis',
        'severity': AppConstants.severityCritical,
        'time': DateTime.now().subtract(const Duration(hours: 4)),
        'message': 'Student outside camp for extended period (2h)',
        'status': 'Resolved',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: alerts.length,
      itemBuilder: (context, index) {
        final alert = alerts[index];
        return _buildAlertCard(alert);
      },
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    final severity = alert['severity'] as String;
    final status = alert['status'] as String;
    final isResolved = status == 'Resolved';
    final time = alert['time'] as DateTime;

    Color severityColor;
    IconData severityIcon;
    
    switch (severity) {
      case AppConstants.severityCritical:
        severityColor = AppTheme.errorColor;
        severityIcon = Icons.error;
        break;
      case AppConstants.severityHigh:
        severityColor = AppTheme.errorColor;
        severityIcon = Icons.warning;
        break;
      case AppConstants.severityMedium:
        severityColor = AppTheme.warningColor;
        severityIcon = Icons.info;
        break;
      case AppConstants.severityLow:
        severityColor = AppTheme.infoColor;
        severityIcon = Icons.notifications;
        break;
      default:
        severityColor = AppTheme.textSecondary;
        severityIcon = Icons.notifications;
    }

    return Dismissible(
      key: Key('alert_${alert['student']}_${time.millisecondsSinceEpoch}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.errorColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.delete,
          color: AppTheme.textPrimary,
        ),
      ),
      onDismissed: (direction) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Alert dismissed'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isResolved
                ? AppTheme.textSecondary.withOpacity(0.1)
                : severityColor.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            // Alert Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Severity Icon
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: severityColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      severityIcon,
                      color: severityColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Alert Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                alert['type'] as String,
                                style: TextStyle(
                                  color: isResolved
                                      ? AppTheme.textSecondary
                                      : AppTheme.textPrimary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  decoration: isResolved
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                            // Severity Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
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
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${alert['student']} - ${alert['name']}',
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Alert Message
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                alert['message'] as String,
                style: TextStyle(
                  color: isResolved
                      ? AppTheme.textSecondary
                      : AppTheme.textPrimary,
                  fontSize: 14,
                ),
              ),
            ),
            
            // Alert Footer
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Time
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: AppTheme.textSecondary,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(time),
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  
                  // Action Buttons
                  Row(
                    children: [
                      if (!isResolved) ...[
                        TextButton.icon(
                          onPressed: () {
                            _showAlertDetails(alert);
                          },
                          icon: const Icon(Icons.visibility, size: 16),
                          label: const Text('View'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.secondaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () {
                            _markAsResolved(alert);
                          },
                          icon: const Icon(Icons.check, size: 16),
                          label: const Text('Resolve'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.successColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        ),
                      ] else
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.successColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.check_circle,
                                color: AppTheme.successColor,
                                size: 14,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Resolved',
                                style: TextStyle(
                                  color: AppTheme.successColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return DateFormat('MMM dd, HH:mm').format(time);
    }
  }

  void _showAlertDetails(Map<String, dynamic> alert) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Alert Details',
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppTheme.textSecondary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Type', alert['type'] as String),
              _buildDetailRow('Student', '${alert['student']} - ${alert['name']}'),
              _buildDetailRow('Severity', alert['severity'] as String),
              _buildDetailRow('Message', alert['message'] as String),
              _buildDetailRow('Time', DateFormat('MMM dd, yyyy HH:mm').format(alert['time'] as DateTime)),
              _buildDetailRow('Status', alert['status'] as String),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _markAsResolved(Map<String, dynamic> alert) {
    setState(() {
      alert['status'] = 'Resolved';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Alert marked as resolved'),
        backgroundColor: AppTheme.successColor,
      ),
    );
  }

  void _showMarkAllAsReadDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardBackground,
          title: const Text(
            'Mark All as Read',
            style: TextStyle(color: AppTheme.textPrimary),
          ),
          content: const Text(
            'Are you sure you want to mark all alerts as read?',
            style: TextStyle(color: AppTheme.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All alerts marked as read'),
                  ),
                );
              },
              child: const Text('Mark All'),
            ),
          ],
        );
      },
    );
  }
}
