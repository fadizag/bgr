# BGR — Background Remover

BGR is an Android-first Flutter app for removing image backgrounds, with a workflow suitable for product photos.

## Product direction
- Android app built with Flutter.
- Arabic-first, right-to-left interface.
- Pick an image from the gallery and preview it before processing.
- Keep the original image unchanged and save the result as a transparent PNG.
- Keep background-removal logic behind a service interface so the engine can be replaced without rebuilding the UI.
- Do not embed API credentials in source code or commit them to Git.

## Current milestone
Repository initialization and the first app shell. Background-removal engine integration, image export, and Android-device testing are follow-up milestones.

## Development
Install Flutter stable and Android Studio with the Android SDK, then run:

```bash
flutter pub get
flutter run
```

## Planned milestones
1. Flutter Android project shell and Arabic RTL UI.
2. Image selection, original/result preview, and transparent PNG export.
3. Connect a background-removal engine and handle loading/errors.
4. Test on real Android devices and optimize output size/quality.

## Security
Never commit service API keys, passwords, or private image data.
