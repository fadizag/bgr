# BGR Product Plan

## Goal
Build an Android-first app to reduce manual effort when removing backgrounds from product photos.

## Workflow requirements
1. Select multiple product images in one action.
2. Keep source images unchanged.
3. Process a batch and show per-image status: waiting, processing, completed, or failed.
4. Default output for product catalog use: clean white background; retain transparent PNG when the chosen engine supports it and the user selects transparency.
5. Save outputs separately and preserve a clear association with each source/product.
6. Allow retrying failed images without rerunning the entire batch.
7. Show progress and a useful error message rather than silently failing.

## Background-removal engine
The user mentioned UltraPic. First investigate whether UltraPic offers an official API or supported integration. Do not assume an API exists. If no supported integration is available, compare an on-device model and other authorized processing services before choosing an engine.

Credentials must not be hardcoded in the app or committed to Git. Any integration must respect the provider's terms and authentication protections.

## Current status
- Flutter app shell and Arabic RTL styling: added.
- Gallery selection and preview: added for the initial single-image shell.
- Multi-image selection: next UI improvement.
- Actual background removal, batch processing, saving, and retries: not implemented yet.
- Android build and device test: not run from this repository session.

## Acceptance criteria for a usable first release
- User can select multiple images.
- Original images remain unchanged.
- Each output is saved independently and can be opened from the device.
- The app reports partial failures and supports retry.
- White-background output is available for product images.
- No secrets are stored in source control.
