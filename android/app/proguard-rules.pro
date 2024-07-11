# Flutter dependencies
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }

# Flutter-related annotations
-keepattributes *Annotation*

# JSON serialization/deserialization
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
-keep class sun.misc.Unsafe { *; }

# Ensure ProGuard does not strip out method names that are called via reflection
-keepclassmembers class * {
    **.valueOf(java.lang.String);
}
