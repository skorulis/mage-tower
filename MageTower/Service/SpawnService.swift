//  Created by Alexander Skorulis on 10/9/2025.

import CoreGraphics
import Foundation

final class SpawnService {
    
    let spawnRadius: CGFloat = 400
    var towerPosition: CGPoint = .zero
    
    func spawn() -> Enemy {
        let angle = CGFloat.random(in: 0..<(2 * .pi))
        print(angle)
        let x = towerPosition.x + spawnRadius * cos(angle)
        let y = towerPosition.y + spawnRadius * sin(angle)
        return .init(spawnPosition: CGPoint(x: x, y: y))
    }
    
}
