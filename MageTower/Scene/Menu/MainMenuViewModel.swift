//Created by Alexander Skorulis on 28/9/2025.

import ASKCoordinator
import Foundation
import Knit
import KnitMacros
import SwiftUI

@Observable final class MainMenuViewModel: CoordinatorViewModel {
    
    var coordinator: ASKCoordinator.Coordinator?
    
    private let gameStore: GameStore
    
    var level: Level = .one
    
    @Resolvable<MageTowerResolver>
    init(gameStore: GameStore) {
        self.gameStore = gameStore
    }
}

// MARK: - Logic

extension MainMenuViewModel {
    
    func start() {
        gameStore.start(level: level)
        coordinator?.push(GamePath.game)
    }
    
}
