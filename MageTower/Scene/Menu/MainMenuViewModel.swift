//Created by Alexander Skorulis on 28/9/2025.

import ASKCoordinator
import Foundation
import Knit
import KnitMacros
import SwiftUI

@Observable final class MainMenuViewModel: CoordinatorViewModel {
    
    var coordinator: ASKCoordinator.Coordinator?
    
    private let gameStore: GameStore
    
    private let persistentStore: PersistentStore
    
    var level: Level = .one
    
    var bestWaveForCurrentLevel: Int? {
        persistentStore.levelRecords.levels[level]?.bestWave
    }
    
    @Resolvable<MageTowerResolver>
    init(
        @Argument coordinator: ASKCoordinator.Coordinator?,
        gameStore: GameStore,
        persistentStore: PersistentStore
    ) {
        self.coordinator = coordinator
        self.gameStore = gameStore
        self.persistentStore = persistentStore
    }
}

// MARK: - Logic

extension MainMenuViewModel {
    
    func start() {
        gameStore.start(level: level, tower: persistentStore.tower)
        coordinator?.push(GamePath.game)
    }
    
    func showLevelCharts() {
        coordinator?.push(GamePath.levelCharts)
    }
    
    func showStatCharts() {
        coordinator?.push(GamePath.statCharts)
    }
    
}
