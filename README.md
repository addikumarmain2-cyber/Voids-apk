# Voids APK

An APK launcher application made by Void.

## Building the APK

### Prerequisites
- Android Studio or command-line tools
- Java Development Kit (JDK) 11 or higher
- Android SDK with API level 34

### Build Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/addikumarmain2-cyber/Voids-apk.git
   cd Voids-apk
   ```

2. **Build using Gradle:**
   ```bash
   ./gradlew assembleDebug
   ```

3. **Locate the APK:**
   - Debug APK: `app/build/outputs/apk/debug/app-debug.apk`

### Automatic Builds

This project uses GitHub Actions to automatically build the APK on every push. The built APK is available in the workflow artifacts.

## Project Structure

```
Voids-apk/
├── app/                          # Main application module
│   ├── src/
│   │   └── main/
│   │       ├── java/            # Java source code
│   │       ├── res/             # Android resources
│   │       └── AndroidManifest.xml
│   ├── build.gradle
│   └── proguard-rules.pro
├── .github/
│   └── workflows/
│       └── Build.yml            # GitHub Actions workflow
├── build.gradle                 # Root build configuration
├── settings.gradle              # Project settings
└── gradle.properties            # Gradle configuration

```

## License

This project is created by Void.
