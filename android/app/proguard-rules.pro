# Keep all TensorFlow Lite classes
-keep class org.tensorflow.** { *; }
-dontwarn org.tensorflow.**

# Optional: keep ML model metadata
-keep class org.checkerframework.** { *; }
-dontwarn org.checkerframework.**

# Keep FlatBuffers
-keep class com.google.flatbuffers.** { *; }
-dontwarn com.google.flatbuffers.**
