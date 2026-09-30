import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants/app_theme.dart';

class CampBoundaryScreen extends StatefulWidget {
  const CampBoundaryScreen({super.key});

  @override
  State<CampBoundaryScreen> createState() => _CampBoundaryScreenState();
}

class _CampBoundaryScreenState extends State<CampBoundaryScreen> {
  GoogleMapController? _mapController;
  
  // Sample camp location (you can change this to actual coordinates)
  static const LatLng _campCenter = LatLng(37.7749, -122.4194);
  static const double _campRadius = 500; // meters
  
  final Set<Circle> _circles = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  void _initializeMap() {
    // Add camp boundary circle
    _circles.add(
      Circle(
        circleId: const CircleId('camp_boundary'),
        center: _campCenter,
        radius: _campRadius,
        fillColor: AppTheme.secondaryColor.withOpacity(0.2),
        strokeColor: AppTheme.secondaryColor,
        strokeWidth: 2,
      ),
    );

    // Add center marker
    _markers.add(
      const Marker(
        markerId: MarkerId('camp_center'),
        position: _campCenter,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: 'Camp Center',
          snippet: 'Main Camp Building',
        ),
      ),
    );

    // Add sample student markers
    _markers.add(
      Marker(
        markerId: const MarkerId('student_1'),
        position: const LatLng(37.7759, -122.4184),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(
          title: 'ST001',
          snippet: 'Inside Camp',
        ),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('student_2'),
        position: const LatLng(37.7739, -122.4204),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(
          title: 'ST014',
          snippet: 'Inside Camp',
        ),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('student_3'),
        position: const LatLng(37.7710, -122.4150),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(
          title: 'ST023',
          snippet: 'Outside Camp',
        ),
      ),
    );
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
          'Camp Boundary',
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
              _showBoundarySettings();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Bar
          _buildStatsBar(),
          
          // Map
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: _campCenter,
                    zoom: 14.5,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  circles: _circles,
                  markers: _markers,
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                ),
                
                // Legend
                Positioned(
                  top: 16,
                  right: 16,
                  child: _buildLegend(),
                ),
              ],
            ),
          ),

          // Boundary Info
          _buildBoundaryInfo(),
        ],
      ),
    );
  }

  Widget _buildStatsBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppTheme.cardBackground,
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              icon: Icons.check_circle,
              label: 'Inside',
              value: '247',
              color: AppTheme.successColor,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppTheme.textSecondary.withOpacity(0.2),
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.warning,
              label: 'Outside',
              value: '3',
              color: AppTheme.errorColor,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppTheme.textSecondary.withOpacity(0.2),
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.help_outline,
              label: 'Unknown',
              value: '0',
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
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

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Legend',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildLegendItem(
            color: AppTheme.successColor,
            label: 'Inside Camp',
          ),
          const SizedBox(height: 4),
          _buildLegendItem(
            color: AppTheme.errorColor,
            label: 'Outside Camp',
          ),
          const SizedBox(height: 4),
          _buildLegendItem(
            color: AppTheme.secondaryColor,
            label: 'Camp Boundary',
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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

  Widget _buildBoundaryInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Boundary Settings',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.check_circle,
                      color: AppTheme.successColor,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Active',
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
          const SizedBox(height: 16),
          _buildInfoRow(Icons.location_on, 'Camp Name', 'Summer Camp 2026'),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.straighten, 'Radius', '${_campRadius.toInt()} meters'),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.people, 'Students Inside', '247 of 250'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showBoundarySettings();
                  },
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Edit Boundary'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondaryColor,
                    foregroundColor: AppTheme.textPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // View history
                  },
                  icon: const Icon(Icons.history, size: 18),
                  label: const Text('View History'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.textPrimary,
                    side: const BorderSide(color: AppTheme.textSecondary),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
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

  void _showBoundarySettings() {
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
                    'Boundary Settings',
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
              ListTile(
                leading: const Icon(Icons.edit_location, color: AppTheme.secondaryColor),
                title: const Text(
                  'Edit Center Location',
                  style: TextStyle(color: AppTheme.textPrimary),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textSecondary),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit location feature coming soon')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.straighten, color: AppTheme.secondaryColor),
                title: const Text(
                  'Adjust Radius',
                  style: TextStyle(color: AppTheme.textPrimary),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textSecondary),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Adjust radius feature coming soon')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications, color: AppTheme.secondaryColor),
                title: const Text(
                  'Alert Settings',
                  style: TextStyle(color: AppTheme.textPrimary),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textSecondary),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Alert settings feature coming soon')),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
