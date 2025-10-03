//  Created by Alexander Skorulis on 12/9/2025.

import ASKCoordinator
import Combine
import Knit
import KnitMacros
import SwiftUI

@Observable final class GameViewModel: CoordinatorViewModel {
    
    let scene: GameScene
    let spawnService: SpawnService
    let enemyService: EnemyService
    let gameStore: GameStore
    let persistentStore: PersistentStore
    let upgradeViewModel: InGameUpgradeViewModel
    
    var coordinator: ASKCoordinator.Coordinator?
    var cancellables = Set<AnyCancellable>()
    var tower: Tower
    var wave: Wave
    var upgrades: GameUpgrades
    
    var toShoot: TimeInterval = 0.5
    
    var speed: Double = 1 {
        didSet {
            scene.physicsWorld.speed = CGFloat(speed)
        }
    }
    
    @Resolvable<MageTowerResolver>
    init(
        enemyService: EnemyService,
        spawnService: SpawnService,
        gameStore: GameStore,
        persistentStore: PersistentStore,
        upgradeViewModel: InGameUpgradeViewModel
    ) {
        self.enemyService = enemyService
        self.spawnService = spawnService
        self.gameStore = gameStore
        self.persistentStore = persistentStore
        self.upgradeViewModel = upgradeViewModel
        scene = GameScene(size: UIScreen.main.bounds.size, enemyService: enemyService)
        
        gameStore.start(level: .one)
        self.tower = gameStore.tower
        self.wave = gameStore.wave
        self.upgrades = persistentStore.upgrades
        
        gameStore.$tower.sink { [unowned self] in
            self.tower = $0
        }
        .store(in: &cancellables)
        
        gameStore.$wave.sink { [unowned self] in
            self.wave = $0
        }
        .store(in: &cancellables)
        
        persistentStore.$upgrades.sink { [unowned self] in
            self.upgrades = $0
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
        gameStore.update(currentTime: time, speed: speed)
        enemyService.updateHits(delta: gameStore.time.deltaTime)
        maybeSpawn()
        maybeShoot()
        checkDeath()
    }
    
    private func checkDeath() {
        if tower.currentHealth <= 0 {
            coordinator?.pop()
        }
    }
    
    private func maybeShoot() {
        toShoot -= gameStore.time.deltaTime
        if toShoot <= 0 {
            toShoot += 0.5
            scene.fireBullet()
        }
    }
    
    private func maybeSpawn() {
        guard enemyService.enemyCount < gameStore.levelParameters.enemyCap else {
            return
        }
        enemyService.spawnTime += gameStore.time.deltaTime
        if enemyService.spawnTime > gameStore.levelParameters.spawnRate {
            enemyService.spawnTime -= gameStore.levelParameters.spawnRate
            var enemy = spawnService.spawn(levelParams: gameStore.levelParameters, wave: wave.number)
            scene.add(enemy: &enemy)
            enemyService.add(enemy: enemy, time: gameStore.time.lastUpdateTime)
        }
    }
}
