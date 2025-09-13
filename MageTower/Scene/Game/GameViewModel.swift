//  Created by Alexander Skorulis on 12/9/2025.

import Combine
import Knit
import KnitMacros
import SwiftUI

@Observable final class GameViewModel {
    
    let scene: GameScene
    let spawnService: SpawnService
    let gameService: GameService
    let enemyService: EnemyService
    
    let level: Level
    let levelParameters: LevelParameters
    
    var wave: Wave = .empty
    
    var cancellables = Set<AnyCancellable>()
    
    @Resolvable<MageTowerResolver>
    init(gameService: GameService, enemyService: EnemyService, spawnService: SpawnService) {
        self.gameService = gameService
        self.enemyService = enemyService
        self.spawnService = spawnService
        self.level = .one
        self.levelParameters = level.params
        scene = GameScene(size: UIScreen.main.bounds.size, enemyService: enemyService)
        scene.onUpdate = { [weak self] time in
            self?.onUpdate(time)
        }
        
        gameService.$wave.sink { [unowned self] wave in
            self.wave = wave
        }
        .store(in: &cancellables)
        
        gameService.start(params: levelParameters)
    }
}

// MARK: - Logic

extension GameViewModel {
    
    func onUpdate(_ time: TimeInterval) {
        gameService.update(time)
        if gameService.time.lastUpdateTime > enemyService.lastSpawn + levelParameters.spawnRate {
            var enemy = spawnService.spawn(levelParams: levelParameters, wave: wave.number)
            scene.add(enemy: &enemy)
            enemyService.add(enemy: enemy, time: gameService.time.lastUpdateTime)
        }
    }
}
