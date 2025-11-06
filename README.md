# FPS Meter for iPhone

A native iOS app built with SwiftUI that displays real-time frames per second (FPS) metrics for your iPhone.

## Features

- Real-time FPS monitoring with color-coded indicator
- Comprehensive statistics: average, min, max FPS
- Frame time display (ms) and sample count
- One-tap reset for all stats
- Dark theme optimized UI

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Getting Started

1. Clone the repository:
   - `git clone https://github.com/subhobhai943/fps-meter-ios.git`
2. Open the Xcode project:
   - `open FPSMeter.xcodeproj`
3. Select a simulator or a connected iPhone.
4. Build and run.

## Continuous Integration (CI)

This repository uses GitHub Actions to build and validate the project on every push and pull request.

- Workflow file: `.github/workflows/ios-build.yml`
- Runners: `macos-latest`
- Xcode: 15.0
- Caching: Swift Package Manager cache
- Artifacts: Build artifacts are uploaded using `actions/upload-artifact@v4` (v3 is deprecated)

### Triggers

- Push to `main`, `develop`
- Pull requests targeting `main`

### What the workflow does

- Checks out the repository
- Sets up Xcode 15
- Caches SwiftPM dependencies
- Resolves packages
- Builds for iOS Simulator
- Compiles Swift files for syntax validation
- Validates `Info.plist`
- Uploads build artifacts
- Runs code quality checks

## Project Structure

```
fps-meter-ios/
├── FPSMeterApp.swift
├── ContentView.swift
├── FPSCounter.swift
├── Info.plist
├── LICENSE
├── README.md
├── Package.swift
├── FPSMeter.xcodeproj/
│   └── project.pbxproj
└── .github/workflows/
    └── ios-build.yml
```

## Notes

- CADisplayLink is used for accurate FPS measurement.
- Statistics use a rolling window of 60 samples.
- CI builds disable code signing and target iOS Simulator.

## License

MIT License. See `LICENSE` for details.
