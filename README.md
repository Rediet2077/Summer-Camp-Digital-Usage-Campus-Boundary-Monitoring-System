# CampGuard - Flutter Mobile App

CampGuard is a comprehensive digital monitoring and camp management system designed for summer camps and intensive training programs. This Flutter mobile application provides the user interface for students, managers, and supervisors to monitor device usage and track camp boundary status.

## Features

### 🎯 Core Functionality
- **Student Management**: Register and manage student profiles
- **Device Registration**: Enroll and monitor student devices (Android/iOS/Windows)
- **Usage Analytics**: Track and analyze application usage with detailed statistics
- **Camp Boundary Monitoring**: Geofencing with real-time location tracking
- **Alerts System**: Multi-severity alert management and notifications
- **Reports**: Daily and weekly usage reports with export options
- **Student Profiles**: Detailed student information with activity timelines

### 📱 Screens Included
1. **Welcome Screen** - App introduction with smooth animations
2. **Login Screen** - Secure authentication with Google login option
3. **Dashboard** - Overview with stats, usage charts, and recent activities
4. **Add Student** - Comprehensive form for student registration
5. **Device Registration** - Enroll devices with platform selection
6. **Usage Analytics** - Time-based usage charts and category breakdowns
7. **Camp Boundary** - Interactive map with geofence visualization
8. **Location Events** - Track student movements in/out of camp
9. **Alerts** - Severity-based alert management
10. **Reports** - Daily/weekly reports with export functionality
11. **Students List** - Searchable and filterable student directory
12. **Student Profile** - Detailed view with tabs for overview, activity, and timeline
13. **Settings** - App preferences and account management

## Technology Stack

### Frontend
- **Flutter** 3.44.8
- **Dart** 3.12.2

### Key Dependencies
- `http` ^1.1.0 - API communication
- `provider` ^6.1.1 - State management
- `shared_preferences` ^2.2.2 - Local storage
- `geolocator` ^10.1.0 - Location services
- `google_maps_flutter` ^2.5.0 - Map integration
- `fl_chart` ^0.65.0 - Charts and graphs
- `font_awesome_flutter` ^10.6.0 - Icons
- `intl` ^0.19.0 - Internationalization
- `flutter_svg` ^2.0.9 - SVG support

## Project Structure

```
lib/
├── constants/
│   ├── app_theme.dart          # Theme configuration (dark/light)
│   └── app_constants.dart      # App-wide constants
├── models/                     # Data models (ready for implementation)
├── screens/                    # All app screens
│   ├── welcome_screen.dart
│   ├── login_screen.dart
│   ├── dashboard_screen.dart
│   ├── add_student_screen.dart
│   ├── device_registration_screen.dart
│   ├── usage_analytics_screen.dart
│   ├── camp_boundary_screen.dart
│   ├── location_events_screen.dart
│   ├── alerts_screen.dart
│   ├── reports_screen.dart
│   ├── students_list_screen.dart
│   ├── student_profile_screen.dart
│   └── settings_screen.dart
├── services/                   # API services (ready for implementation)
├── utils/                      # Utility functions
├── widgets/
│   └── stat_card.dart         # Reusable stat card widget
└── main.dart                   # App entry point
```

## Setup Instructions

### Prerequisites
- Flutter SDK 3.44.8 or higher
- Dart SDK 3.12.2 or higher
- Android Studio / VS Code with Flutter extensions
- Git

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/Rediet2077/Summer-Camp-Digital-Usage-Campus-Boundary-Monitoring-System.git
cd UserFront
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
# On connected device or emulator
flutter run

# For specific platform
flutter run -d <device_id>
```

4. **Build for production**
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## Configuration

### API Endpoints
Update the base URL and endpoints in `lib/constants/app_constants.dart`:
```dart
static const String baseUrl = 'https://api.campguard.com';
```

### Theme Customization
Modify colors and styles in `lib/constants/app_theme.dart`:
```dart
static const Color primaryColor = Color(0xFF1E3A8A);
static const Color secondaryColor = Color(0xFF3B82F6);
```

### Google Maps Setup

1. **Android**: Add your API key in `android/app/src/main/AndroidManifest.xml`:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_API_KEY_HERE"/>
```

2. **iOS**: Add your API key in `ios/Runner/AppDelegate.swift`:
```swift
GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
```

## Features by Screen

### Dashboard
- Real-time student and device statistics
- Usage by category pie chart
- Most used applications list
- Recent app activity
- Bottom navigation bar

### Usage Analytics
- Time period selector (Day/Week/Month)
- Usage trend line chart
- Category breakdown with percentages
- Top applications with trends
- Progress indicators

### Camp Boundary
- Interactive Google Maps integration
- Circular geofence visualization
- Student location markers
- Inside/Outside status indicators
- Legend and boundary settings

### Alerts
- Severity-based filtering (Critical/High/Medium/Low)
- Dismissible alert cards
- Alert details modal
- Resolve functionality
- Mark all as read option

### Reports
- Daily and weekly reports
- Date/week selector
- Bar and line charts
- Export options (PDF/CSV/Email)
- Summary statistics

## State Management

The app uses **Provider** for state management. To integrate:

1. Create provider classes in `lib/services/`
2. Wrap MaterialApp with MultiProvider in `main.dart`
3. Use Consumer or Provider.of in widgets

Example:
```dart
Provider.of<AuthService>(context, listen: false).login();
```

## API Integration

API service files are ready to be implemented in `lib/services/`:
- `auth_api.dart` - Authentication
- `student_api.dart` - Student management
- `usage_api.dart` - Usage tracking
- `location_api.dart` - Location events
- `alert_api.dart` - Alert management
- `report_api.dart` - Report generation

## Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

## Deployment

### Android
1. Update `android/app/build.gradle` with version and signing config
2. Generate release APK: `flutter build apk --release`
3. Generate AAB for Play Store: `flutter build appbundle`

### iOS
1. Update version in `ios/Runner/Info.plist`
2. Configure signing in Xcode
3. Build: `flutter build ios --release`
4. Archive and upload via Xcode

## Design Guidelines

### Colors
- **Primary**: Dark Blue (#1E3A8A)
- **Secondary**: Blue (#3B82F6)
- **Success**: Green (#10B981)
- **Warning**: Orange (#F59E0B)
- **Error**: Red (#EF4444)

### Typography
- **Headers**: Bold, 20-32px
- **Body**: Regular, 14-16px
- **Captions**: 11-13px

### Spacing
- Small: 8px
- Medium: 16px
- Large: 24px
- XLarge: 32px

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is part of the Summer Camp Digital Usage & Campus Boundary Monitoring System.

## Support

For issues, questions, or suggestions:
- Create an issue on GitHub
- Contact: [Repository Owner]

## Acknowledgments

- Flutter team for the amazing framework
- Contributors and testers
- Design inspiration from modern camp management systems

---

**Version**: 1.0.0  
**Last Updated**: September 30, 2026  
**Platform**: Flutter (Android/iOS/Web)
