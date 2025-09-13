//  Created by Alexander Skorulis on 10/9/2025.

import Foundation
import QuartzCore

final class GameService {
    
    var time: Time = .init()
    
    func start() {
        // Initialize time tracking
        time = .init()
    }
    
    func update(_ currentTime: TimeInterval) {
        // Calculate delta time (time since last frame)
        time.update(currentTime)
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
    
    mutating func update(_ currentTime: TimeInterval) {
        // Calculate delta time (time since last frame)
        
        deltaTime = currentTime - lastUpdateTime
        lastUpdateTime = currentTime

        // Add to total game time
        totalGameTime += deltaTime
    }
}
