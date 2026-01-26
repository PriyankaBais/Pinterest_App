# Pinterest Clone - Complete Setup Guide

## 📋 Step-by-Step Instructions

### Step 1: Install Flutter Dependencies

Open terminal in the project directory and run:

```bash
flutter pub get
```

This will install all required packages:
- flutter_riverpod (State Management)
- go_router (Navigation)
- dio (Networking)
- cached_network_image (Image Caching)
- shimmer (Loading Effects)
- flutter_staggered_grid_view (Grid Layout)

### Step 2: Get API Key

#### Option A: Pexels API (Recommended)
1. Go to https://www.pexels.com/api/
2. Sign up for a free account
3. Get your API key
4. Open `lib/core/constants/api_constants.dart`
5. Replace `YOUR_PEXELS_API_KEY` with your actual API key

#### Option B: Unsplash API (Alternative)
1. Go to https://unsplash.com/developers
2. Create an app and get your Access Key
3. Update `api_constants.dart` with your Unsplash key
4. Update `dio_client.dart` to use Unsplash base URL

### Step 3: Run the App

```bash
flutter run
```

## 🏗️ Project Structure

```
lib/
├── core/                          # Core utilities
│   ├── constants/                 # API keys, app constants
│   ├── network/                   # Dio client setup
│   ├── router/                    # GoRouter configuration
│   └── theme/                     # App theme
│
├── features/                      # Feature modules
│   ├── home/                      # Home feed
│   │   ├── data/                  # Data layer
│   │   │   ├── datasources/      # API calls
│   │   │   ├── models/            # Data models
│   │   │   └── repositories/      # Repository implementations
│   │   ├── domain/                # Business logic
│   │   │   ├── entities/          # Business entities
│   │   │   ├── repositories/      # Repository interfaces
│   │   │   └── usecases/          # Use cases
│   │   └── presentation/          # UI layer
│   │       ├── providers/         # Riverpod providers
│   │       ├── screens/           # Screens
│   │       └── widgets/           # Reusable widgets
│   │
│   ├── search/                    # Search feature
│   ├── pin_detail/                # Pin detail view
│   ├── create/                    # Create pin
│   ├── profile/                   # User profile
│   └── main/                      # Main navigation
│
└── main.dart                      # App entry point
```

## 🎨 Features Implemented

✅ Clean Architecture (Presentation, Domain, Data layers)
✅ Riverpod State Management
✅ GoRouter Navigation
✅ Masonry Grid Layout (Pinterest-style)
✅ Image Caching with CachedNetworkImage
✅ Shimmer Loading Effects
✅ Pull-to-Refresh
✅ Infinite Scroll
✅ Search Functionality
✅ Pin Detail Screen
✅ Bottom Navigation Bar
✅ Pinterest-like UI/UX

## 🔧 Configuration

### API Configuration

Edit `lib/core/constants/api_constants.dart`:

```dart
static const String pexelsApiKey = 'YOUR_API_KEY_HERE';
```

### Theme Customization

Edit `lib/core/theme/app_theme.dart` to customize colors, fonts, etc.

## 📱 Building for Production

### Android APK
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 🐛 Troubleshooting

### API Not Working?
- Check if API key is correctly set
- Verify internet connection
- Check API rate limits
- App will fallback to sample images if API fails

### Images Not Loading?
- Check internet connection
- Verify API key is valid
- Check CachedNetworkImage configuration

### Navigation Issues?
- Ensure GoRouter is properly configured
- Check route paths match

## 📝 Next Steps (Optional Enhancements)

- [ ] Add authentication with Clerk
- [ ] Implement local caching with Hive/SharedPreferences
- [ ] Add user profiles and boards
- [ ] Implement pin saving functionality
- [ ] Add social features (likes, comments)
- [ ] Implement video pins
- [ ] Add dark mode support

## 🎯 Assignment Checklist

- ✅ Clean Architecture implemented
- ✅ All required packages installed
- ✅ Riverpod state management
- ✅ GoRouter navigation
- ✅ Pexels/Unsplash API integration
- ✅ Pinterest-like UI
- ✅ Masonry grid layout
- ✅ Image caching
- ✅ Shimmer loading
- ✅ Search functionality
- ✅ Pull-to-refresh
- ✅ Infinite scroll

## 📚 Resources

- [Pexels API Docs](https://www.pexels.com/api/documentation/)
- [Unsplash API Docs](https://unsplash.com/documentation)
- [Flutter Riverpod Docs](https://riverpod.dev/)
- [GoRouter Docs](https://pub.dev/packages/go_router)
