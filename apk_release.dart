
One way that i use to reduce my app size is to use;
---------------------------------------------------

flutter clean

before i run the build command;
---------------------------------------------------
flutter build appbundle --target-platform android-arm,android-arm64


When i run the build command without the clean command, i get around 32mb, but if i run the clean command first, i get around 18mb




Update version:A.B.C+X in pubspec.yaml.
For Android:
-----------------------------------------------------------------
A.B.C represents the versionName such as 1.0.0.

X (the number after the +) represents the versionCode such as 1, 2, 3, etc.

When you run flutter packages get after updating this version in the pubspec file, the versionName and versionCode in local.properties are updated which are later picked up in the build.gradle (app) when you build your flutter project using flutter build or flutter run which is ultimately responsible for setting the versionName and versionCode for the apk.

For iOS:
-------------------------------------------------------------------
A.B.C represents the CFBundleShortVersionString such as 1.0.0.

X (the number after the +) represents the CFBundleVersion such as 1, 2, 3, etc.