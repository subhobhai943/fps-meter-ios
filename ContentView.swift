import SwiftUI

struct ContentView: View {
    @StateObject private var fpsCounter = FPSCounter()
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Title
                Text("FPS Meter")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                // Main FPS Display
                VStack(spacing: 10) {
                    Text("\(Int(fpsCounter.currentFPS))")
                        .font(.system(size: 80, weight: .bold, design: .monospaced))
                        .foregroundColor(fpsColorForValue(fpsCounter.currentFPS))
                    
                    Text("FPS")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.vertical, 20)
                
                // Statistics
                VStack(spacing: 15) {
                    HStack {
                        StatView(title: "Average", value: String(format: "%.1f", fpsCounter.averageFPS))
                        Spacer()
                        StatView(title: "Min", value: String(format: "%.1f", fpsCounter.minFPS))
                        Spacer()
                        StatView(title: "Max", value: String(format: "%.1f", fpsCounter.maxFPS))
                    }
                    
                    HStack {
                        StatView(title: "Frame Time", value: String(format: "%.2f ms", fpsCounter.frameTime))
                        Spacer()
                        StatView(title: "Samples", value: "\(fpsCounter.sampleCount)")
                    }
                }
                .padding(.horizontal, 20)
                
                // Reset Button
                Button(action: {
                    fpsCounter.reset()
                }) {
                    Text("Reset Stats")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(Color.blue.opacity(0.8))
                        .cornerRadius(25)
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .padding(.top, 50)
        }
        .onAppear {
            fpsCounter.startMonitoring()
        }
        .onDisappear {
            fpsCounter.stopMonitoring()
        }
    }
    
    private func fpsColorForValue(_ fps: Double) -> Color {
        switch fps {
        case 50...:
            return .green
        case 30..<50:
            return .yellow
        default:
            return .red
        }
    }
}

struct StatView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}