# 📌 Pinterest Clone Mobile App

A pixel-perfect Pinterest clone built with Flutter, demonstrating Clean Architecture, Riverpod state management, and modern Flutter best practices.

## ✨ Features

- 🏠 **Home Feed**: Masonry grid layout with curated pins
- 🔍 **Search**: Real-time search with shimmer loading effects
- 📌 **Pin Details**: Full-screen pin view with animations
- ➕ **Create**: Create new pins (placeholder)
- 👤 **Profile**: User profile screen
- 🎨 **Pinterest-like UI**: Pixel-perfect design matching Pinterest app
- 🔄 **Pull-to-Refresh**: Refresh feed by pulling down
- ♾️ **Infinite Scroll**: Automatically loads more pins
- 🖼️ **Image Caching**: Efficient image loading and caching
- ⚡ **Shimmer Effects**: Beautiful loading animations

## 🏗️ Architecture

This project follows **Clean Architecture** principles:

- **Presentation Layer**: UI components, screens, widgets, and Riverpod providers
- **Domain Layer**: Business logic, entities, use cases, and repository interfaces
- **Data Layer**: Data sources, models, and repository implementations

## 📦 Required Packages

All packages are already added to `pubspec.yaml`:

- `flutter_riverpod: ^3.2.0` - State management
- `go_router: ^14.2.0` - Navigation
- `dio: ^5.9.0` - HTTP client
- `cached_network_image: ^3.4.1` - Image caching
- `shimmer: ^3.0.0` - Loading effects
- `flutter_staggered_grid_view: ^0.7.0` - Masonry grid

## 🚀 Quick Start

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Configure API Key

#### Option A: Pexels API (Recommended)
1. Sign up at https://www.pexels.com/api/
2. Get your free API key
3. Open `lib/core/constants/api_constants.dart`
4. Replace `YOUR_PEXELS_API_KEY` with your key:

```dart
static const String pexelsApiKey = 'YOUR_ACTUAL_API_KEY';
```

#### Option B: Unsplash API
1. Sign up at https://unsplash.com/developers
2. Create an app and get Access Key
3. Update the API constants file

### 3. Run the App

```bash
flutter run
```

## 📱 Screenshots

The app includes:
- Home screen with masonry grid
- Search screen with real-time results
- Pin detail screen with full image view
- Bottom navigation bar (Home, Search, Create, Notifications, Profile)

## 🎯 Assignment Requirements Met

✅ **Clean Architecture** - Properly structured with Presentation, Domain, Data layers
✅ **Riverpod State Management** - All state managed with Riverpod providers
✅ **GoRouter Navigation** - Declarative routing setup
✅ **Pexels/Unsplash API** - Integrated with fallback to sample images
✅ **Pinterest-like UI** - Pixel-perfect design matching the original app
✅ **Masonry Grid** - Staggered grid layout for pins
✅ **Image Caching** - Efficient image loading with CachedNetworkImage
✅ **Shimmer Loading** - Beautiful loading effects
✅ **Pull-to-Refresh** - Refresh functionality
✅ **Infinite Scroll** - Auto-loading more content

## 📂 Project Structure

```
lib/
├── core/
│   ├── constants/        # API keys, app constants
│   ├── network/          # Dio client
│   ├── router/           # GoRouter setup
│   └── theme/            # App theme
│
├── features/
│   ├── home/             # Home feed feature
│   ├── search/           # Search feature
│   ├── pin_detail/       # Pin detail view
│   ├── create/           # Create pin
│   ├── profile/          # User profile
│   └── main/             # Main navigation
│
└── main.dart
```

## 🔧 Configuration

### API Setup
Edit `lib/core/constants/api_constants.dart` to set your API key.

### Theme Customization
Edit `lib/core/theme/app_theme.dart` to customize colors and styling.

## 📦 Building for Production

### Android APK
```bash
flutter build apk --release
```

The APK will be in `build/app/outputs/flutter-apk/app-release.apk`

### iOS
```bash
flutter build ios --release
```

## 🐛 Troubleshooting

**API not working?**
- Verify API key is correct
- Check internet connection
- App falls back to sample images if API fails

**Images not loading?**
- Check internet connection
- Verify API key is valid
- Check CachedNetworkImage configuration

**Navigation issues?**
- Ensure GoRouter routes are properly configured
- Check route paths match

## 📝 Backend Requirements

This app uses **external APIs** (Pexels/Unsplash) for images. No backend setup required!

However, if you want to add features like:
- User authentication
- Saving pins to boards
- User profiles
- Social features (likes, comments)

You would need to set up a backend (Firebase, Supabase, or custom Node.js/Flask server).

## 🎨 UI/UX Features

- Smooth scrolling with masonry grid
- Pull-to-refresh gesture
- Infinite scroll loading
- Shimmer loading effects
- Smooth page transitions
- Pinterest-style bottom navigation
- Image caching for performance

## 📚 Resources

- [Pexels API Documentation](https://www.pexels.com/api/documentation/)
- [Unsplash API Documentation](https://unsplash.com/documentation)
- [Flutter Riverpod](https://riverpod.dev/)
- [GoRouter](https://pub.dev/packages/go_router)

## 👨‍💻 Development

This project was built following Clean Architecture principles and Flutter best practices. All code is well-organized, documented, and follows Dart/Flutter conventions.

## 📄 License

This project is for educational/assignment purposes.

---

**Note**: Remember to add your API key before running the app!
