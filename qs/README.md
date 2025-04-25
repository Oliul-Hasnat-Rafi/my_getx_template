# MyGetX Template

A Flutter project template designed for building scalable and maintainable cross-platform applications using the GetX state management library. This template provides a clean architecture to streamline development for Android, iOS, web, and desktop platforms.

*Last Updated: April 25, 2025*

## Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Technology Stack](#technology-stack)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Running the App](#running-the-app)
- [Internationalization](#internationalization)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Clean Architecture**: Modular design with clear separation of concerns
- **State Management**: Efficient state management with GetX
- **Responsive Design**: Adaptive layouts using flutter_screenutil
- **Multi-platform Support**: Android, iOS, Web, macOS, Linux, and Windows
- **Internationalization**: Built-in localization support
- **Routing**: Simple navigation with Go Router
- **Dependency Injection**: Using GetIt for service locator pattern
- **Theme Customization**: Light and dark theme support
- **Local Storage**: Persistent storage with get_storage
- **HTTP Client**: API integration with Dio and HTTP packages
- **Form Validation**: Comprehensive input validation
- **Asset Management**: Organized asset handling for images and SVGs

## Project Structure

The project is organized with a modular architecture to enhance maintainability and scalability. Below is an overview of the key directories and files:

```
my_getx_template/
├── lib/                            # Main source code
│   ├── src/                        # Core application logic
│   │   ├── controller/             # GetX controllers
│   │   │   ├── data_controller/    # Controllers for data management
│   │   │   ├── screen_controller/  # Controllers for screen-specific logic
│   │   │   ├── service/            # Services for API and local data
│   │   │   │   ├── api/            # API service integration
│   │   │   │   ├── error_handlers/ # Error handling logic
│   │   │   │   ├── functions/      # Service-related utility functions
│   │   │   │   ├── local_data/     # Local data storage logic
│   │   ├── core/                   # Core utilities and configurations
│   │   │   ├── theme/              # App themes and styling
│   │   │   ├── utils/              # General utility functions
│   │   │   ├── validators/         # Input and form validation
│   │   │   ├── values/             # Constant values and configurations
│   │   ├── model/                  # Data models
│   │   │   ├── app_model.dart      # Core app models
│   │   │   ├── pogo_model/         # Plain Old Dart Objects (POGO) models
│   │   │   ├── response_model/     # Models for API responses
│   │   ├── view/                   # UI screens and widgets
│   │   │   ├── home/               # Home screen UI
│   │   │   ├── screen/             # Other screen UIs
│   │   │   ├── widget/             # Reusable widgets
│   ├── components.dart             # Shared UI components
│   ├── l10n/                       # Internationalization files
│   ├── main.dart                   # Application entry point
├── assets/                         # Static resources
│   ├── icons/                      # SVG and other icon files
│   ├── images/                     # Image assets
│   ├── flags/                      # Language flag images
```

### Key Directories

- `lib/src/controller/`: Contains GetX controllers for managing state and business logic, organized into data and screen-specific controllers.
- `lib/src/service/`: Manages API calls, error handling, and local data storage, ensuring separation of concerns.
- `lib/src/core/`: Houses reusable utilities, themes, validators, and constants for consistent app behavior.
- `lib/src/model/`: Defines data models, including app-specific models, POGOs, and API response models.
- `lib/src/view/`: Contains UI code for screens and reusable widgets, following a modular design.
- `lib/l10n/`: Contains localization files for internationalization support.
- `assets/`: Stores static assets like images, icons, and flag images for language selection.

## Technology Stack

This template uses the following packages and technologies:

- **UI & Responsive Design**:
  - flutter_screenutil: ^5.9.0
  - google_fonts: ^6.1.0
  - flutter_svg: ^2.0.9
  - on_process_button_widget: ^2.0.2
  - on_popup_window_widget: ^0.0.8

- **State Management & Routing**:
  - get: ^4.6.6 (GetX framework)
  - go_router: ^15.0.0
  - get_it: ^8.0.3 (Dependency injection)

- **Data & Storage**:
  - get_storage: ^2.1.1
  - path_provider: ^2.1.5
  - intl: ^0.19.0

- **Networking**:
  - http: ^1.1.2
  - dio: ^5.8.0+1

- **Platform Features**:
  - permission_handler: ^11.0.1
  - share_plus: ^10.1.4
  - fluttertoast: ^8.2.4

## Prerequisites

To work with this project, ensure you have the following installed:

- Flutter SDK (version 3.5.4 or higher)
- Dart SDK (bundled with Flutter)
- A code editor like VS Code or Android Studio
- Git for version control
- Platform-specific SDKs:
  - **Android**: Android SDK (via Android Studio)
  - **iOS**: Xcode (for macOS)
  - **Web**: Chrome or another supported browser
  - **Desktop**: Dependencies for Linux, macOS, or Windows development

## Setup Instructions

1. **Clone the repository**:

   ```bash
   git clone https://github.com/yourusername/my_getx_template.git
   cd my_getx_template
   ```

2. **Install dependencies**: Fetch all required packages using:

   ```bash
   flutter pub get
   ```

3. **Configure assets**: The assets are already properly configured in the pubspec.yaml file.

4. **Set up platform-specific requirements**:

   - **Android**: Connect an Android emulator or device.
   - **iOS**: Configure Xcode with a valid developer account.
   - **Web**: No additional setup required.
   - **Desktop**: Follow Flutter's desktop setup guide for your platform.

## Running the App

Run the app on your desired platform with the following commands:

- **Android/iOS**:

  ```bash
  flutter run
  ```

- **Web**:

  ```bash
  flutter run -d chrome
  ```

- **Desktop** (e.g., macOS):

  ```bash
  flutter run -d macos
  ```

To build a release version:

```bash
flutter build <platform> 
```

## Internationalization

This template includes support for multiple languages. The internationalization is handled using Flutter's built-in localization framework. Language files are located in the `lib/l10n/` directory.

To add a new language:
1. Create a new ARB file in the `lib/l10n/` directory (e.g., `app_fr.arb` for French)
2. Run `flutter gen-l10n` to generate localization code
3. Language selection UI is already implemented in the app

## Testing

Run tests using:

```bash
flutter test
```

The `test/` directory contains unit and widget tests. Add new tests as needed to maintain code quality and reliability.

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Make changes and commit (`git commit -m "Add your feature"`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

Please ensure your code follows the project's coding standards and includes appropriate tests.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
