//Created by Alexander Skorulis on 27/9/2025.

import Combine
import Foundation
import QuartzCore

final class GameStore: ObservableObject {
    @Published var tower: Tower = .init()
    
    @Published var wave: Wave = .empty
    
    @Published var level: Level
    @Published var levelParameters: LevelParameters
    
    @Published var time: Time = .init()
    
    init() {
        self.level = .one
        self.levelParameters = Level.one.params
    }
    
    func start(level: Level) {
        self.level = level
        self.levelParameters = levelParameters
        
        wave = .init(
            number: 1,
            time: 0,
            duration: levelParameters.waveDuration
        )
        // Initialize time tracking
        time = .init()
        
        tower.currentHealth = tower.value(.health)
    }
    
    func update(currentTime: TimeInterval, speed: Double) {
        // Calculate delta time (time since last frame)
        time.update(currentTime: currentTime, speed: speed)
        wave.add(delta: time.deltaTime)
    }
    
}

struct Time {
    // Time tracking properties
    var lastUpdateTime: TimeInterval = 0
    var deltaTime: TimeInterval = 0
    var totalGameTime: TimeInterval = 0
    var gameStartTime: TimeInterval = 0
    
    init() {
        gameStartTime = CACurrentMediaTime()
        lastUpdateTime = gameStartTime
    }
    
    mutating func update(currentTime: TimeInterval, speed: Double) {
        // Calculate delta time (time since last frame)
        
        deltaTime = (currentTime - lastUpdateTime) * speed
        lastUpdateTime = currentTime

        // Add to total game time
        totalGameTime += deltaTime
    }
}
