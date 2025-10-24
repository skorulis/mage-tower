//  Created by Alexander Skorulis on 12/9/2025.

import ASKCoordinator
import Combine
import Knit
import KnitMacros
import SpriteKit
import SwiftUI

@Observable final class GameViewModel: CoordinatorViewModel {
    
    let scene: GameScene
    let spawnService: SpawnService
    let enemyService: EnemyService
    let weaponService: WeaponService
    let gameStore: GameStore
    let persistentStore: PersistentStore
    let upgradeViewModel: InGameUpgradeViewModel
    
    var coordinator: ASKCoordinator.Coordinator? {
        didSet {
            upgradeViewModel.coordinator = coordinator
        }
    }
    var cancellables = Set<AnyCancellable>()
    var tower: Tower
    var wallet: Wallet
    var wave: Wave
    var upgrades: GameUpgrades
    
    var statistics: GameStatistics
    var dialog: Dialog?
    
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
            size: .zero,
            enemyService: enemyService,
            speed: 1,
        )
        
        self.tower = gameStore.tower
        self.wallet = gameStore.wallet
        self.wave = gameStore.wave
        self.statistics = gameStore.statistics
        self.upgrades = persistentStore.upgrades
        
        gameStore.$tower.sink { [unowned self] in
            self.tower = $0
            self.scene.updateRange($0.range)
        }
        .store(in: &cancellables)
        
        gameStore.$wallet.sink { [unowned self] in
            self.wallet = $0
        }
        .store(in: &cancellables)
        
        gameStore.$statistics.sink { [unowned self] in
            self.statistics = $0
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

extension GameViewModel {
    enum Dialog: Equatable {
        case statistics
        case finish
    }
}

// MARK: - Logic

extension GameViewModel {
    
    func showStats() {
        dialog = .statistics
    }
    
    func handleHamburgerAction(_ action: HamburgerMenu.Action) {
        switch action {
        case .endRound:
            self.tower.currentHealth = 0
        }
    }
    
    func onUpdate(_ time: TimeInterval) -> Time? {
        if scene.isPaused {
            return nil
        }
        gameStore.update(currentTime: time, speed: speed)
        enemyService.updateHits(delta: gameStore.time.deltaTime)
        maybeSpawnEnemy()
        maybeShoot()
        checkDeath()
        return self.gameStore.time
    }
    
    private func checkDeath() {
        if tower.currentHealth <= 0 {
            // Update level records with current game performance
            persistentStore.updateLevelRecord(
                level: gameStore.level,
                wave: wave.number,
                income: wallet.totalEarned,
            )
            
            self.dialog = .finish
            self.scene.isPaused = true
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
