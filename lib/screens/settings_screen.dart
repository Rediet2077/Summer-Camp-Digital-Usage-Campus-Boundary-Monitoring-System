import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = true;
  bool _locationEnabled = true;
  bool _usageMonitoringEnabled = true;

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
          'Settings',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Account Section
          _buildSectionHeader('Account'),
          _buildAccountCard(),
          const SizedBox(height: 24),

          // Preferences Section
          _buildSectionHeader('Preferences'),
          _buildPreferencesCard(),
          const SizedBox(height: 24),

          // Monitoring Section
          _buildSectionHeader('Monitoring'),
          _buildMonitoringCard(),
          const SizedBox(height: 24),

          // Privacy Section
          _buildSectionHeader('Privacy & Security'),
          _buildPrivacyCard(),
          const SizedBox(height: 24),

          // About Section
          _buildSectionHeader('About'),
          _buildAboutCard(),
          const SizedBox(height: 24),

          // Logout Button
          _buildLogoutButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: AppTheme.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAccountCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: AppTheme.secondaryColor.withOpacity(0.2),
              child: const Text(
                'JD',
                style: TextStyle(
                  color: AppTheme.secondaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: const Text(
              'John Doe',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text(
              'john.doe@example.com',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 13,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: AppTheme.secondaryColor),
              onPressed: () {
                // Edit profile
              },
            ),
          ),
          const Divider(color: AppTheme.textSecondary, height: 1),
          _buildMenuItem(
            icon: Icons.person,
            title: 'Profile Settings',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.lock,
            title: 'Change Password',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Receive push notifications',
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          const Divider(color: AppTheme.textSecondary, height: 1, indent: 60),
          _buildSwitchTile(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            subtitle: 'Use dark theme',
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
          ),
          const Divider(color: AppTheme.textSecondary, height: 1, indent: 60),
          _buildMenuItem(
            icon: Icons.language,
            title: 'Language',
            subtitle: 'English',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMonitoringCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            icon: Icons.location_on,
            title: 'Location Tracking',
            subtitle: 'Allow camp boundary monitoring',
            value: _locationEnabled,
            onChanged: (value) {
              setState(() {
                _locationEnabled = value;
              });
            },
          ),
          const Divider(color: AppTheme.textSecondary, height: 1, indent: 60),
          _buildSwitchTile(
            icon: Icons.apps,
            title: 'Usage Monitoring',
            subtitle: 'Track app usage',
            value: _usageMonitoringEnabled,
            onChanged: (value) {
              setState(() {
                _usageMonitoringEnabled = value;
              });
            },
          ),
          const Divider(color: AppTheme.textSecondary, height: 1, indent: 60),
          _buildMenuItem(
            icon: Icons.devices,
            title: 'My Devices',
            subtitle: '2 devices connected',
            onTap: () {},
          ),
          const Divider(color: AppTheme.textSecondary, height: 1, indent: 60),
          _buildMenuItem(
            icon: Icons.security,
            title: 'Permissions',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            onTap: () {},
          ),
          const Divider(color: AppTheme.textSecondary, height: 1, indent: 60),
          _buildMenuItem(
            icon: Icons.description,
            title: 'Terms of Service',
            onTap: () {},
          ),
          const Divider(color: AppTheme.textSecondary, height: 1, indent: 60),
          _buildMenuItem(
            icon: Icons.data_usage,
            title: 'Data Usage',
            onTap: () {},
          ),
          const Divider(color: AppTheme.textSecondary, height: 1, indent: 60),
          _buildMenuItem(
            icon: Icons.delete_forever,
            title: 'Clear Data',
            titleColor: AppTheme.errorColor,
            onTap: () {
              _showClearDataDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.info,
            title: 'App Version',
            subtitle: '1.0.0',
            onTap: () {},
          ),
          const Divider(color: AppTheme.textSecondary, height: 1, indent: 60),
          _buildMenuItem(
            icon: Icons.help,
            title: 'Help & Support',
            onTap: () {},
          ),
          const Divider(color: AppTheme.textSecondary, height: 1, indent: 60),
          _buildMenuItem(
            icon: Icons.bug_report,
            title: 'Report a Bug',
            onTap: () {},
          ),
          const Divider(color: AppTheme.textSecondary, height: 1, indent: 60),
          _buildMenuItem(
            icon: Icons.star,
            title: 'Rate App',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.secondaryColor),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? AppTheme.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 13,
              ),
            )
          : null,
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppTheme.textSecondary,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.secondaryColor),
      title: Text(
        title,
        style: const TextStyle(
          color: AppTheme.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: AppTheme.textSecondary,
          fontSize: 13,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.successColor,
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        onPressed: () {
          _showLogoutDialog();
        },
        icon: const Icon(Icons.logout),
        label: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.errorColor,
          side: const BorderSide(color: AppTheme.errorColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Perform logout
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully')),
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: AppTheme.errorColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardBackground,
          title: const Text(
            'Clear Data',
            style: TextStyle(color: AppTheme.textPrimary),
          ),
          content: const Text(
            'This will clear all local app data. This action cannot be undone.',
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
                    content: Text('Data cleared successfully'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: AppTheme.errorColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
