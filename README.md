MyGetX Template

A Flutter project template designed for building scalable and maintainable cross-platform applications using the GetX state management library. This template provides a clean architecture to streamline development for Android, iOS, web, and desktop platforms.

## Table of Contents

- Project Structure
- Prerequisites
- Setup Instructions
- Running the App
- Testing
- Contributing
- License

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
│   │   │   ├── pogo_model/        # Plain Old Dart Objects (POGO) models
│   │   │   ├── response_model/     # Models for API responses
│   │   ├── view/                   # UI screens and widgets
│   │   │   ├── home/               # Home screen UI
│   │   │   ├── screen/             # Other screen UIs
│   │   │   ├── widget/             # Reusable widgets
│   ├── components.dart             # Shared UI components
│   ├── main.dart                   # Application entry point


### Key Directories

- `lib/src/controller/`: Contains GetX controllers for managing state and business logic, organized into data and screen-specific controllers.
- `lib/src/service/`: Manages API calls, error handling, and local data storage, ensuring separation of concerns.
- `lib/src/core/`: Houses reusable utilities, themes, validators, and constants for consistent app behavior.
- `lib/src/model/`: Defines data models, including app-specific models, POGOs, and API response models.
- `lib/src/view/`: Contains UI code for screens and reusable widgets, following a modular design.
- `assets/`: Stores static assets like images, fonts, and other resources.
- `test/`: Includes unit and widget tests to ensure code reliability.

## Prerequisites

To work with this project, ensure you have the following installed:

- Flutter (version 3.x or higher)
- Dart (bundled with Flutter)
- A code editor like VS Code or Android Studio
- Git for version control
- Platform-specific SDKs:
  - **Android**: Android SDK (via Android Studio)
  - **iOS**: Xcode (for macOS)
  - **Web**: Chrome or another supported browser
  - **Desktop**: Dependencies for Linux, macOS, or Windows

## Setup Instructions

1. **Clone the repository**:

   ```bash
   git clone https://github.com/Oliul-Hasnat-Rafi/my_getx_template.git
   cd my_getx_template
   ```

2. **Install dependencies**: Fetch all required packages using:

   ```bash
   flutter pub get
   ```

3. **Configure assets**: Ensure assets (e.g., images, fonts) are declared in `pubspec.yaml` under the `flutter.assets` section.

4. **Set up platform-specific requirements**:

   - **Android**: Connect an Android emulator or device.
   - **iOS**: Configure Xcode with a valid developer account.
   - **Web**: No additional setup required.
   - **Desktop**: Follow Flutter's desktop setup guide for your platform (Flutter Desktop).

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
5. Open a pull request on GitHub.

Please ensure your code follows the project's coding standards and includes appropriate tests.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
