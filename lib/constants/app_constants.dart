class AppConstants {
  // App Info
  static const String appName = 'CampGuard';
  static const String appTagline = 'Smart Monitoring for a Safe Camp';
  
  // API Endpoints (Update these with your actual backend URLs)
  static const String baseUrl = 'https://api.campguard.com';
  static const String loginEndpoint = '/api/auth/login';
  static const String registerEndpoint = '/api/auth/register';
  static const String studentEndpoint = '/api/students';
  static const String deviceEndpoint = '/api/devices';
  static const String usageEndpoint = '/api/usage';
  static const String locationEndpoint = '/api/location/events';
  static const String alertsEndpoint = '/api/alerts';
  static const String reportsEndpoint = '/api/reports';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userNameKey = 'user_name';
  static const String userRoleKey = 'user_role';
  static const String themeKey = 'theme_mode';
  
  // User Roles
  static const String roleAdmin = 'ADMIN';
  static const String roleManager = 'MANAGER';
  static const String roleSupervisor = 'SUPERVISOR';
  static const String roleStudent = 'STUDENT';
  
  // Usage Categories
  static const String categoryEducation = 'Education';
  static const String categoryProductivity = 'Productivity';
  static const String categorySocialMedia = 'Social Media';
  static const String categoryEntertainment = 'Entertainment';
  static const String categoryGaming = 'Gaming';
  static const String categoryCommunication = 'Communication';
  static const String categoryOther = 'Other';
  static const String categoryUnknown = 'Unknown';
  
  // Alert Types
  static const String alertExcessiveSocialMedia = 'Excessive Social Media';
  static const String alertExcessiveEntertainment = 'Excessive Entertainment';
  static const String alertRestrictedApp = 'Restricted Application';
  static const String alertLeftCamp = 'Student Left Camp';
  static const String alertMonitoringDisabled = 'Monitoring Disabled';
  static const String alertPermissionRemoved = 'Permission Removed';
  static const String alertDeviceOffline = 'Device Offline';
  static const String alertUnusualUsage = 'Unusual Usage Pattern';
  
  // Alert Severity
  static const String severityLow = 'Low';
  static const String severityMedium = 'Medium';
  static const String severityHigh = 'High';
  static const String severityCritical = 'Critical';
  
  // Location Event Types
  static const String eventLeftCamp = 'LEFT_CAMP';
  static const String eventEnteredCamp = 'ENTERED_CAMP';
  static const String eventUnknown = 'UNKNOWN';
  
  // Monitoring Status
  static const String statusActive = 'Active';
  static const String statusInactive = 'Inactive';
  static const String statusPaused = 'Paused';
  static const String statusOffline = 'Offline';
  
  // Camp Boundary Status
  static const String boundaryInside = 'Inside';
  static const String boundaryOutside = 'Outside';
  static const String boundaryUnknown = 'Unknown';
  
  // Date Formats
  static const String dateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'MMM dd, yyyy HH:mm';
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;
  
  // Permissions
  static const String permissionLocation = 'Location';
  static const String permissionUsageAccess = 'Usage Access';
  static const String permissionNotifications = 'Notifications';
  static const String permissionBackgroundLocation = 'Background Location';
}
