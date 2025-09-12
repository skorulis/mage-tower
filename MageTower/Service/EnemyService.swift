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
}
