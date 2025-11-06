import Foundation
import QuartzCore

class FPSCounter: ObservableObject {
    @Published var currentFPS: Double = 0.0
    @Published var averageFPS: Double = 0.0
    @Published var minFPS: Double = Double.greatestFiniteMagnitude
    @Published var maxFPS: Double = 0.0
    @Published var frameTime: Double = 0.0
    @Published var sampleCount: Int = 0
    
    private var displayLink: CADisplayLink?
    private var lastTimestamp: CFTimeInterval = 0
    private var fpsHistory: [Double] = []
    private let maxHistoryCount = 60 // Keep last 60 FPS samples
    
    init() {
        reset()
    }
    
    func startMonitoring() {
        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkDidFire))
        displayLink?.add(to: .main, forMode: .common)
    }
    
    func stopMonitoring() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func displayLinkDidFire(displayLink: CADisplayLink) {
        if lastTimestamp == 0 {
            lastTimestamp = displayLink.timestamp
            return
        }
        
        let currentTimestamp = displayLink.timestamp
        let deltaTime = currentTimestamp - lastTimestamp
        
        // Calculate current FPS
        let fps = 1.0 / deltaTime
        
        // Update published properties on main thread
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.currentFPS = fps
            self.frameTime = deltaTime * 1000 // Convert to milliseconds
            
            // Add to history
            self.fpsHistory.append(fps)
            if self.fpsHistory.count > self.maxHistoryCount {
                self.fpsHistory.removeFirst()
            }
            
            // Update statistics
            self.updateStatistics()
        }
        
        lastTimestamp = currentTimestamp
    }
    
    private func updateStatistics() {
        guard !fpsHistory.isEmpty else { return }
        
        sampleCount = fpsHistory.count
        averageFPS = fpsHistory.reduce(0, +) / Double(fpsHistory.count)
        minFPS = fpsHistory.min() ?? 0.0
        maxFPS = fpsHistory.max() ?? 0.0
    }
    
    func reset() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.currentFPS = 0.0
            self.averageFPS = 0.0
            self.minFPS = Double.greatestFiniteMagnitude
            self.maxFPS = 0.0
            self.frameTime = 0.0
            self.sampleCount = 0
            self.fpsHistory.removeAll()
            self.lastTimestamp = 0
        }
    }
    
    deinit {
        stopMonitoring()
    }
}