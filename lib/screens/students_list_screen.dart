import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../constants/app_constants.dart';

class StudentsListScreen extends StatefulWidget {
  const StudentsListScreen({super.key});

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Active', 'Inside', 'Outside', 'Group A', 'Group B'];

  @override
  void dispose() {
    _searchController.dispose();
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
          'Students',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: AppTheme.textPrimary),
            onPressed: () {
              _showSortOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(),
          
          // Filter Chips
          _buildFilterBar(),
          
          // Summary Stats
          _buildSummaryBar(),
          
          // Students List
          Expanded(
            child: _buildStudentsList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Student screen
        },
        backgroundColor: AppTheme.secondaryColor,
        child: const Icon(Icons.person_add),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: AppTheme.textPrimary),
        decoration: InputDecoration(
          hintText: 'Search by name or ID...',
          hintStyle: const TextStyle(color: AppTheme.textSecondary),
          prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppTheme.textSecondary),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: AppTheme.cardBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            backgroundColor: AppTheme.cardBackground,
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

  Widget _buildSummaryBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppTheme.cardBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('Total', '250', AppTheme.secondaryColor),
          _buildSummaryItem('Active', '235', AppTheme.successColor),
          _buildSummaryItem('Inside', '247', AppTheme.successColor),
          _buildSummaryItem('Outside', '3', AppTheme.errorColor),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStudentsList() {
    final students = [
      {
        'id': 'ST001',
        'name': 'John Doe',
        'group': 'Group A',
        'status': AppConstants.statusActive,
        'location': AppConstants.boundaryInside,
        'device': 'Samsung Galaxy A54',
      },
      {
        'id': 'ST014',
        'name': 'Jane Smith',
        'group': 'Group A',
        'status': AppConstants.statusActive,
        'location': AppConstants.boundaryInside,
        'device': 'iPhone 13',
      },
      {
        'id': 'ST023',
        'name': 'Mike Johnson',
        'group': 'Group B',
        'status': AppConstants.statusActive,
        'location': AppConstants.boundaryOutside,
        'device': 'Google Pixel 7',
      },
      {
        'id': 'ST027',
        'name': 'Sarah Wilson',
        'group': 'Group A',
        'status': AppConstants.statusActive,
        'location': AppConstants.boundaryInside,
        'device': 'OnePlus 11',
      },
      {
        'id': 'ST041',
        'name': 'Tom Brown',
        'group': 'Group B',
        'status': AppConstants.statusActive,
        'location': AppConstants.boundaryInside,
        'device': 'Samsung Galaxy S23',
      },
      {
        'id': 'ST006',
        'name': 'Emily Davis',
        'group': 'Group A',
        'status': AppConstants.statusOffline,
        'location': AppConstants.boundaryUnknown,
        'device': 'iPhone 14 Pro',
      },
      {
        'id': 'ST012',
        'name': 'Alex Martinez',
        'group': 'Group B',
        'status': AppConstants.statusActive,
        'location': AppConstants.boundaryInside,
        'device': 'Xiaomi 13',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return _buildStudentCard(student);
      },
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student) {
    final isOutside = student['location'] == AppConstants.boundaryOutside;
    final isOffline = student['status'] == AppConstants.statusOffline;
    
    Color locationColor;
    IconData locationIcon;
    
    switch (student['location']) {
      case AppConstants.boundaryInside:
        locationColor = AppTheme.successColor;
        locationIcon = Icons.check_circle;
        break;
      case AppConstants.boundaryOutside:
        locationColor = AppTheme.errorColor;
        locationIcon = Icons.warning;
        break;
      default:
        locationColor = AppTheme.textSecondary;
        locationIcon = Icons.help_outline;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isOutside
              ? AppTheme.errorColor.withOpacity(0.3)
              : AppTheme.textSecondary.withOpacity(0.1),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppTheme.secondaryColor.withOpacity(0.2),
              child: Text(
                student['id'].toString().substring(2),
                style: const TextStyle(
                  color: AppTheme.secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: locationColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.cardBackground,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          student['name'] as String,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  student['id'] as String,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    student['group'] as String,
                    style: const TextStyle(
                      color: AppTheme.secondaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.phone_android,
                  color: AppTheme.textSecondary,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    student['device'] as String,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: locationColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    locationIcon,
                    color: locationColor,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    student['location'] as String,
                    style: TextStyle(
                      color: locationColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isOffline ? AppTheme.textSecondary : AppTheme.successColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        onTap: () {
          _showStudentDetails(student);
        },
      ),
    );
  }

  void _showStudentDetails(Map<String, dynamic> student) {
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
                    'Student Details',
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
              _buildDetailRow('Student ID', student['id'] as String),
              _buildDetailRow('Name', student['name'] as String),
              _buildDetailRow('Group', student['group'] as String),
              _buildDetailRow('Status', student['status'] as String),
              _buildDetailRow('Location', student['location'] as String),
              _buildDetailRow('Device', student['device'] as String),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to student profile
                      },
                      icon: const Icon(Icons.person, size: 18),
                      label: const Text('View Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // View usage
                      },
                      icon: const Icon(Icons.analytics, size: 18),
                      label: const Text('View Usage'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.textPrimary,
                        side: const BorderSide(color: AppTheme.textSecondary),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
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

  void _showSortOptions() {
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
                'Sort By',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.sort_by_alpha, color: AppTheme.secondaryColor),
                title: const Text('Name (A-Z)', style: TextStyle(color: AppTheme.textPrimary)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.numbers, color: AppTheme.secondaryColor),
                title: const Text('Student ID', style: TextStyle(color: AppTheme.textPrimary)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.group, color: AppTheme.secondaryColor),
                title: const Text('Group', style: TextStyle(color: AppTheme.textPrimary)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.location_on, color: AppTheme.secondaryColor),
                title: const Text('Location Status', style: TextStyle(color: AppTheme.textPrimary)),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
