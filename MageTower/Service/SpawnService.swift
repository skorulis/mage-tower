//  Created by Alexander Skorulis on 10/9/2025.

import CoreGraphics
import Foundation

final class SpawnService {
    
    let spawnRadius: CGFloat = 500
    
    func spawn() -> Enemy {
        let angle = CGFloat.random(in: 0..<(2 * .pi))
        print(angle)
        let x = spawnRadius * cos(angle)
        let y = spawnRadius * sin(angle)
        return .init(spawnPosition: CGPoint(x: x, y: y))
    }
    
}
