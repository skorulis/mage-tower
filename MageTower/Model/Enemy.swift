//  Created by Alexander Skorulis on 10/9/2025.

import Foundation
import SpriteKit

struct Enemy {
    let id = UUID()
    let spawnPosition: CGPoint
    var health: Double = 2
    var node: SKNode?
    
    init(
        spawnPosition: CGPoint,
        health: Double
    ) {
        self.spawnPosition = spawnPosition
        self.health = health
    }
}
