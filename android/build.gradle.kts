allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Pindahkan folder build project ke luar folder android
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    // Set build dir per subproject agar terpisah
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    // Supaya modul :app dievaluasi dulu, jika perlu
    project.evaluationDependsOn(":app")

    // Konfigurasi JVM target Kotlin dan Java untuk semua subprojects
    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
        kotlinOptions {
            jvmTarget = "17"
        }
    }
    tasks.withType<JavaCompile>().configureEach {
        sourceCompatibility = "17"
        targetCompatibility = "17"
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
