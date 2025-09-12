//  Created by Alexander Skorulis on 12/9/2025.

import Foundation
import SpriteKit

final class EnemyService {
    
    var enemies: [UUID: Enemy] = [:]
    
    func add(enemy: Enemy) {
        enemies[enemy.id] = enemy
    }
    
    // Return true if the enemy is dead
    @discardableResult func hit(uuid: UUID) -> Bool {
        guard var enemy = enemies[uuid] else {
            return true
        }
        enemy.health -= 1
        guard enemy.health <= 0 else {
            enemies[uuid] = enemy
            return false
        }
        killed(enemy: enemy)
        return true
    }
    
    func killed(enemy: Enemy) {
        enemy.node?.removeFromParent()
        enemies.removeValue(forKey: enemy.id)
    }
    
    func closest() -> Enemy? {
        var best: Enemy?
        var bestValue: CGFloat = .infinity
        for enemy in enemies.values {
            guard let pos = enemy.node?.position else {
                continue
            }
            let dist = (pos.x * pos.x) + (pos.y * pos.y)
            if dist < bestValue {
                best = enemy
                bestValue = dist
            }
        }
        
        return best
    }
}
