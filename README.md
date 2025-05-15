# 🗳️ Swtak (صوتك) - Your Voice

A civic engagement platform that empowers citizens to propose, evaluate, and vote on projects related to parliamentary and municipal development. Designed to support transparent decision-making by enabling public participation and surfacing community priorities.

## 🏆 Achievement
- ***6th place in the Crown Prince Government Applications Award***
  
## 👥 Contributors

- [@Ahmad Alsafoty](https://github.com/alsafoty)
- [@Mohammad Arnaout](https://github.com/Moh-Arnaout)
- [@Mu`taz Moneer](https://github.com/Sopkii)
- [@Abdelrhman khshman](https://github.com/abd-khshman)
- [@Odai Tmrawe](https://github.com/odaiAltmrawe)
  
## 📱 Screenshots

![image_2025-05-14_21-54-31](https://github.com/user-attachments/assets/0d5e33e9-4380-46c8-aafa-d9e064b2bcb0)

## 🚀 Features

### 📝 Citizen Engagement
- **Proposal Submission**: Easy-to-use interface for citizens to submit development proposals
- **Public Voting Mechanism**: Secure and transparent voting system for community decisions
- **Community Priority Surfacing**: Real-time tracking and visualization of community priorities

### 🤖 AI-Powered Analysis
- **Smart Suggestion System**: AI-driven analysis of citizen proposals and feedback
- **Trend Analysis**: Identification of emerging community needs and priorities
- **Automated Insights**: Data-driven recommendations for parliament and municipalities

### 🏛️ Government Integration
- **Project Evaluation System**: Comprehensive framework for assessing proposal feasibility
- **Transparent Decision-Making Process**: Clear visibility into proposal status and outcomes
- **Municipal Collaboration**: Direct communication channel between citizens and local authorities

## 🛠️ Tech Stack
- **Frontend**: Flutter
- **State Management**: BLoC (Business Logic Component)
- **Backend**: Firebase
- **Architecture**: Clean Architecture with BLoC pattern

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
   git clone https://github.com/mahmoud0alabsi/Swtak-CivicEngagementPlatform.git
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

4. OpenAI API Configuration
   - Get your API key from [OpenAI Platform](https://platform.openai.com/api-keys)
   - Open `lib/features/citizens_suggestions/data/repositories/ai_suggestions_repo_impl.dart`
   - Replace `'Add-Your-API-Key'` with your OpenAI API key:
     ```dart
     final String _apiKey = 'your-openai-api-key-here';
     ```
   - Note: The AI analysis feature requires a valid OpenAI API key to function

5. Run the app
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
