# Pinterest Clone - Project Structure

## Clean Architecture Layers

```
lib/
├── core/                          # Core utilities and shared code
│   ├── constants/                 # App constants
│   ├── network/                   # Network configuration
│   ├── router/                    # Navigation setup
│   ├── theme/                     # App theme
│   └── utils/                     # Helper functions
│
├── features/                      # Feature modules
│   └── home/                      # Home feature
│       ├── data/                  # Data Layer
│       │   ├── datasources/       # Remote/Local data sources
│       │   ├── models/            # Data models (JSON serialization)
│       │   └── repositories/      # Repository implementations
│       │
│       ├── domain/                # Domain Layer
│       │   ├── entities/          # Business entities
│       │   ├── repositories/      # Repository interfaces
│       │   └── usecases/          # Business logic
│       │
│       └── presentation/          # Presentation Layer
│           ├── providers/         # Riverpod providers
│           ├── screens/           # UI screens
│           └── widgets/           # Reusable widgets
│
└── main.dart                      # App entry point
```

## Installation Steps

1. **Install packages**: Run `flutter pub get`
2. **Get API Key**: Sign up at https://www.pexels.com/api/ (or use Unsplash)
3. **Run the app**: `flutter run`
