// ✅ إعدادات buildscript
buildscript {
    repositories {
        google()        // ✅ مطلوب للوصول إلى Google Plugins
        mavenCentral()  // ✅ للوصول إلى مكتبات Kotlin وغيرها
    }

    dependencies {
        classpath("com.google.gms:google-services:4.4.0") // ✅ مطلوب لتفعيل Firebase
    }
}

// ✅ إعدادات الموديولات
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ تخصيص مجلد البناء
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

// ✅ إعداد buildDir لكل subproject
subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// ✅ تأكيد تقييم المشروع الرئيسي أولًا
subprojects {
    project.evaluationDependsOn(":app")
}

// ✅ مهمة التنظيف
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
