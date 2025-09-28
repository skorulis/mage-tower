//  Created by Alexander Skorulis on 12/9/2025.

import Combine
import Knit
import KnitMacros
import SwiftUI

@Observable final class GameViewModel {
    
    let scene: GameScene
    let spawnService: SpawnService
    let enemyService: EnemyService
    let gameStore: GameStore
    
    let upgradeViewModel: InGameUpgradeViewModel
    
    var cancellables = Set<AnyCancellable>()
    
    var tower: Tower
    
    var wave: Wave
    
    @Resolvable<MageTowerResolver>
    init(
        enemyService: EnemyService,
        spawnService: SpawnService,
        gameStore: GameStore,
        upgradeViewModel: InGameUpgradeViewModel
    ) {
        self.enemyService = enemyService
        self.spawnService = spawnService
        self.gameStore = gameStore
        self.upgradeViewModel = upgradeViewModel
        scene = GameScene(size: UIScreen.main.bounds.size, enemyService: enemyService)
        
        gameStore.start(level: .one)
        self.tower = gameStore.tower
        self.wave = gameStore.wave
        
        gameStore.$tower.sink { [unowned self] in
            self.tower = $0
        }
        .store(in: &cancellables)
        
        gameStore.$wave.sink { [unowned self] in
            self.wave = $0
        }
        .store(in: &cancellables)
        
        scene.onUpdate = { [weak self] time in
            self?.onUpdate(time)
        }
    }
}

// MARK: - Logic

extension GameViewModel {
    
    func onUpdate(_ time: TimeInterval) {
        gameStore.update(time)
        if gameStore.time.lastUpdateTime > enemyService.lastSpawn + gameStore.levelParameters.spawnRate {
            var enemy = spawnService.spawn(levelParams: gameStore.levelParameters, wave: wave.number)
            scene.add(enemy: &enemy)
            enemyService.add(enemy: enemy, time: gameStore.time.lastUpdateTime)
        }
    }
}
