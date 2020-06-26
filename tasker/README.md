# tasker

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Generate Bundle

bundletool build-apks --bundle=/home/joe/repos/tasker/tasker/build/app/outputs/bundle/release/app-release.aab \
    --output=/home/joe/repos/tasker/tasker/build/app/outputs/bundle/release \
    --ks=/home/joe/repos/tasker/tasker/keystore/key.jks \
    --ks-pass=file:/MyApp/keystore.pwd \
    --ks-key-alias= \
    --key-pass=file:/MyApp/key.pwd


## Web Build
https://flutter.dev/docs/get-started/web

## Change icon

run:
flutter pub run flutter_launcher_icons:main
then build
flutter build apk  --split-per-abi
flutter install -d ONEPLUS A3003

