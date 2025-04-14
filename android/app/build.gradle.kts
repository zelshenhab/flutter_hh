plugins {
    id("com.android.application")
    id("kotlin-android")
    // ✅ مهم: هذا خاص بـ Flutter
    id("dev.flutter.flutter-gradle-plugin")
    // ✅ مهم: هذا خاص بـ Firebase
    id("com.google.gms.google-services") 
}

android {
    namespace = "com.example.flutter_hh"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // ✅ تم التثبيت

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.flutter_hh"

        // ✅ رفع الحد الأدنى للإصدار إلى 23 لتوافق record_audio وغيره
        minSdk = 23

        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
