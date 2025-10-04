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
    let weaponService: WeaponService
    let gameStore: GameStore
    let persistentStore: PersistentStore
    let upgradeViewModel: InGameUpgradeViewModel
    
    var coordinator: ASKCoordinator.Coordinator?
    var cancellables = Set<AnyCancellable>()
    var tower: Tower
    var wave: Wave
    var upgrades: GameUpgrades
    
    var sceneSize: CGSize = .zero {
        didSet {
            scene.size = sceneSize
        }
    }
    
    var speed: Double {
        didSet {
            scene.physicsWorld.speed = CGFloat(speed)
        }
    }
    
    @Resolvable<MageTowerResolver>
    init(
        enemyService: EnemyService,
        weaponService: WeaponService,
        spawnService: SpawnService,
        gameStore: GameStore,
        persistentStore: PersistentStore,
        upgradeViewModel: InGameUpgradeViewModel
    ) {
        self.enemyService = enemyService
        self.weaponService = weaponService
        self.spawnService = spawnService
        self.gameStore = gameStore
        self.persistentStore = persistentStore
        self.upgradeViewModel = upgradeViewModel
        self.speed = 1
        scene = GameScene(
            size: UIScreen.main.bounds.size,
            enemyService: enemyService,
            speed: 1,
        )
        
        gameStore.start(level: .one)
        self.tower = gameStore.tower
        self.wave = gameStore.wave
        self.upgrades = persistentStore.upgrades
        
        gameStore.$tower.sink { [unowned self] in
            self.tower = $0
            self.scene.updateRange($0.range)
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
        
        // Set initial range
        scene.updateRange(tower.range)
    }
}

// MARK: - Logic

extension GameViewModel {
    
    func onUpdate(_ time: TimeInterval) -> Time{
        gameStore.update(currentTime: time, speed: speed)
        enemyService.updateHits(delta: gameStore.time.deltaTime)
        maybeSpawnEnemy()
        maybeShoot()
        checkDeath()
        return self.gameStore.time
    }
    
    private func checkDeath() {
        if tower.currentHealth <= 0 {
            coordinator?.pop()
        }
    }
    
    private func maybeShoot() {
        weaponService.fireTime += gameStore.time.deltaTime
        if weaponService.fireTime >= 0.5 {
            weaponService.fireTime -= 0.5
            scene.fireBullet()
        }
    }
    
    private func maybeSpawnEnemy() {
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
