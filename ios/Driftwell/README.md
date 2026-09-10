# Driftwell iOS portfolio concept

Driftwell is a fictional SwiftUI appointment-booking app built as a portfolio demonstration. It includes service discovery, service details, a three-step booking flow, a local booking summary, and profile screens.

No appointment, payment, or personal information leaves the app. All content and state are local demo data.

## Run

Open `Driftwell.xcodeproj` in Xcode and run the `Driftwell` scheme on an iPhone simulator running iOS 17 or newer.

Command-line build:

```sh
xcodebuild -project Driftwell.xcodeproj -scheme Driftwell -sdk iphonesimulator -configuration Debug CODE_SIGNING_ALLOWED=NO build
```
