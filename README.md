# FPS Meter for iPhone

A native iOS app built with SwiftUI that displays real-time frames per second (FPS) metrics for your iPhone.

## Features

- **Real-time FPS monitoring** - Displays current FPS with color-coded indicators
- **Comprehensive statistics** - Shows average, minimum, and maximum FPS
- **Frame time display** - Shows frame rendering time in milliseconds
- **Sample tracking** - Keeps track of the number of samples collected
- **Statistics reset** - Reset all statistics with a single button
- **Dark theme** - Optimized for viewing in various lighting conditions

## Technical Details

### Requirements
- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

### Architecture
- **SwiftUI** - Modern declarative UI framework
- **ObservableObject** - Reactive data flow with Combine
- **CADisplayLink** - High-precision frame rate monitoring
- **Color-coded FPS display**:
  - 🟢 Green: 50+ FPS (Excellent)
  - 🟡 Yellow: 30-49 FPS (Good)
  - 🔴 Red: Below 30 FPS (Poor)

### Core Components

#### FPSCounter
- Manages CADisplayLink for frame rate monitoring
- Calculates real-time FPS, averages, and statistics
- Maintains a rolling history of 60 FPS samples
- Thread-safe updates using DispatchQueue

#### ContentView
- Main SwiftUI interface with gradient background
- Large, prominent FPS display
- Statistics panel with organized metrics
- Reset functionality for clearing data

## Installation

1. Clone this repository
2. Open `FPSMeter.xcodeproj` in Xcode
3. Select your target device (iPhone)
4. Build and run the project

## Usage

1. Launch the app on your iPhone
2. The FPS meter will automatically start monitoring
3. View real-time FPS in the large central display
4. Check statistics panel for detailed metrics
5. Tap "Reset Stats" to clear all collected data

## File Structure

```
FPSMeter/
├── FPSMeterApp.swift      # App entry point
├── ContentView.swift      # Main UI view
├── FPSCounter.swift       # FPS monitoring logic
└── README.md             # This file
```

## Performance Notes

- The app uses CADisplayLink tied to the main thread for accurate FPS measurement
- Minimal performance impact on the device
- Statistics are calculated in real-time without blocking the UI
- Memory usage is optimized with a rolling sample history

## License

MIT License - Feel free to use and modify as needed.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.