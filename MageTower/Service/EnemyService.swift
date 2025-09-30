//  Created by Alexander Skorulis on 12/9/2025.

import Combine
import Foundation
import SpriteKit
import Knit
import KnitMacros

final class EnemyService {
    
    private let gameStore: GameStore
    private let persistentStore: PersistentStore
    
    var enemies: [UUID: Enemy] = [:]
    var contacts: [UUID: TimeInterval] = [:]
    var enemyCount: Int { enemies.count }
    var lastSpawn: TimeInterval = 0
    
    private var tower: Tower
    
    var cancellables = Set<AnyCancellable>()
    
    @Resolvable<MageTowerResolver>
    init(
        gameStore: GameStore,
        persistentStore: PersistentStore
    ) {
        self.gameStore = gameStore
        self.persistentStore = persistentStore
        self.tower = gameStore.tower
        
        gameStore.$tower.sink { [unowned self] in
            self.tower = $0
        }
        .store(in: &cancellables)
        
    }
    
    func add(enemy: Enemy, time: TimeInterval) {
        enemies[enemy.id] = enemy
        lastSpawn = time
    }
    
    // Return true if the enemy is dead
    @discardableResult func hit(uuid: UUID) -> HitResult {
        guard var enemy = enemies[uuid] else {
            return .miss // Shouldn't happen
        }
        enemy.health -= tower.value(.damage)
        guard enemy.health <= 0 else {
            enemies[uuid] = enemy
            return .damage
        }
        killed(enemy: enemy)
        return .kill(enemy)
    }
    
    func killed(enemy: Enemy) {
        enemy.node?.removeFromParent()
        enemies.removeValue(forKey: enemy.id)
        let xp: Double = 1
        gameStore.tower.xp += xp
        persistentStore.upgrades.essence += xp * gameStore.tower.value(.essenceConversion)
        contacts.removeValue(forKey: enemy.id)
    }
    
    func startContact(id: UUID) {
        guard let enemy = enemies[id] else {
            return
        }
        contacts[id] = 1
        takeDamage(enemy: enemy)
    }
    
    func takeDamage(enemy: Enemy) {
        gameStore.tower.currentHealth -= gameStore.levelParameters.damage(wave: enemy.wave)
    }
    
    func updateHits(delta: Double) {
        for (key, value) in contacts {
            var newValue = value - delta
            if newValue < 0 {
                newValue += 1
                if let enemy = enemies[key] {
                   takeDamage(enemy: enemy)
                }
            }
            contacts[key] = newValue
        }
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

enum HitResult {
    case miss
    case damage
    case kill(Enemy)
}
