//  Created by Alexander Skorulis on 12/9/2025.

import Knit
import KnitMacros
import SwiftUI

@Observable final class GameViewModel {
    
    let scene: GameScene
    let spawnService: SpawnService
    let gameService: GameService
    let enemyService: EnemyService
    
    @Resolvable<MageTowerResolver>
    init(gameService: GameService, enemyService: EnemyService, spawnService: SpawnService) {
        self.gameService = gameService
        self.enemyService = enemyService
        self.spawnService = spawnService
        scene = GameScene(size: UIScreen.main.bounds.size, enemyService: enemyService)
        scene.onUpdate = { [weak self] time in
            self?.onUpdate(time)
        }
    }
}

// MARK: - Logic

extension GameViewModel {
    
    func onUpdate(_ time: TimeInterval) {
        gameService.update(time)
        if gameService.time.lastUpdateTime > enemyService.lastSpawn + 0.5 {
            var enemy = spawnService.spawn()
            scene.add(enemy: &enemy)
            enemyService.add(enemy: enemy, time: gameService.time.lastUpdateTime)
        }
    }
}
