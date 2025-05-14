# 🗳️ Swtak (صوتك) - Your Voice

A civic engagement platform that empowers citizens to propose, evaluate, and vote on projects related to parliamentary and municipal development. Designed to support transparent decision-making by enabling public participation and surfacing community priorities.

## 🏆 Achievement
- ***6th place in the Crown Prince Government Applications Award***
- 
## 👥 Contributors

- [@Ahmad Alsafoty](https://github.com/alsafoty)
- [@Mohammad Arnaout](https://github.com/Moh-Arnaout)
- [@Mu`taz Moneer](https://github.com/Sopkii)
- [@Abdelrhman khshman](https://github.com/abd-khshman)
- [@Odai Tmrawe](https://github.com/)
  
## 📱 Screenshots

![image_2025-05-14_21-54-31](https://github.com/user-attachments/assets/0d5e33e9-4380-46c8-aafa-d9e064b2bcb0)

## 🚀 Features
- Citizen proposal submission
- Project evaluation system
- Public voting mechanism
- Transparent decision-making process
- Community priority surfacing
- Cross-device accessibility

## 🛠️ Tech Stack
- **Frontend**: Flutter
- **State Management**: BLoC (Business Logic Component)
- **Backend**: Firebase
- **Architecture**: Clean Architecture with BLoC pattern

## 📱 Platform Support
- iOS
- Android

## 🎯 Project Goals
- Empower citizen participation in local governance
- Facilitate transparent decision-making processes
- Bridge the gap between citizens and government entities
- Enable data-driven community development

## 🔧 Getting Started

### Prerequisites
- Flutter SDK (version 3.0.0 or higher)
- Dart SDK (version 3.0.0 or higher)
- Firebase account and project setup
- Android Studio / VS Code with Flutter extensions
- Git
- Android SDK (for Android development)
- Xcode (for iOS development, macOS only)
- CocoaPods (for iOS development, macOS only)

### Environment Setup
1. Install Flutter SDK
   ```bash
   # For Windows
   # Download Flutter SDK from https://docs.flutter.dev/get-started/install/windows
   # Extract the zip file and add Flutter to your PATH

   # For macOS
   brew install flutter

   # For Linux
   sudo snap install flutter --classic
   ```

2. Verify Flutter installation
   ```bash
   flutter doctor
   ```

3. Install required IDE extensions
   - VS Code: Flutter and Dart extensions
   - Android Studio: Flutter and Dart plugins

### Project Setup
1. Clone the repository
   ```bash
   git clone https://github.com/your-username/swtak.git
   cd swtak
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Firebase Configuration
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication, Firestore, and Storage
   - Download and add the configuration files:
     - Android: `google-services.json` to `android/app/`
     - iOS: `GoogleService-Info.plist` to `ios/Runner/`
   - For iOS, install pods:
     ```bash
     cd ios
     pod install
     cd ..
     ```

4. Run the app
   ```bash
   # For development
   flutter run

   # For release build
   flutter build apk --release  # Android
   flutter build ios --release  # iOS
   ```

### Development Guidelines
- Follow the project's code style guide
- Use BLoC pattern for state management
- Write unit tests for business logic
- Follow Flutter's widget testing guidelines
- Use proper error handling and logging

### Common Issues and Solutions
- If you encounter build issues, try:
  ```bash
  flutter clean
  flutter pub get
  ```
- For iOS build issues:
  ```bash
  cd ios
  pod deintegrate
  pod install
  ```
- For Android build issues:
  - Ensure Android SDK is properly installed
  - Check `android/local.properties` for correct SDK path


## Contact

For issues or questions, open a GitHub issue or contact:
- 📧 Email: [malabsi034@gmail.com](mailto:malabsi034@gmail.com)
- 💼 LinkedIn: [linkedin.com/in/mahmoud-alabsi](https://www.linkedin.com/in/mahmoud-alabsi)
- 💻 GitHub: [github.com/mahmoud0alabsi](https://github.com/mahmoud0alabsi)
