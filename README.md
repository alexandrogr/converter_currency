# Currency Converter App

The Currency Converter App is a Flutter-based mobile application designed to provide users with an easy and efficient way to convert currencies in real-time. The app leverages the **Drift** package for local database management, ensuring that users can access currency conversion data even when offline. Additionally, the app implements a **local cache** to store frequently accessed data, reducing the need for repeated network requests and improving overall performance.

## Features
- **Real-time Currency Conversion**: Fetch up-to-date exchange rates from a reliable API.
- **Offline Support**: Utilizes **Drift** to store exchange rates locally, allowing users to access data without an internet connection.
- **Local Cache**: Implements a caching mechanism to minimize redundant API calls and enhance app responsiveness.
- **Cross-Platform**: Works seamlessly on both Android and iOS devices.

## Technologies Used
- **Flutter**: A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Drift**: A powerful database library for Flutter that simplifies local data storage and management.
- **Local Cache**: A caching mechanism to store and retrieve data efficiently, reducing dependency on network requests.

---

## Main Description

- For demonstration purposes, the Demo class is used. It generates data for exchange rates.
- All requests are cached in temporary storage.
- Drift is used to save the history.

## How to Run the Project

Follow these steps to set up and run the Currency Converter App on your local machine.

### Prerequisites
- Flutter SDK installed on your machine.
- Dart SDK (comes with Flutter).
- Android Studio/Xcode for Android/iOS development.
- An IDE like Visual Studio Code or Android Studio.

### Step-by-Step Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/currency-converter-app.git
   cd currency-converter-app
2. **Install Dependencies**:
- Run the following command to install all the required dependencies:
   ```bash
   flutter pub get
3. **Build Runner**:
- Generating Drift database, routes, data classes and injectable classes code using `build_runner`:
  ```bash
  flutter pub run build_runner build --delete-conflicting-outputs
4. **Run the App on Android:**:
- Connect an Android device or start an emulator.
- Run the following command:
   ```bash
   flutter run
5. **Run the App on iOS:**:
- Ensure Xcode is installed and configured.
- Connect an iOS device or start a simulator.
- Run the following command:
   ```bash
   flutter run
6. **Build the App:**:
- To build the app for Android:
   ```bash
   flutter build apk
- To build the app for iOS:
   ```bash
   flutter build ios
## Demo preview
![Currency Converter Demo](./demo/demo.gif)