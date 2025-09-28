//  Created by Alexander Skorulis on 24/9/2025.

import Combine
import Foundation
import KnitMacros

@Observable final class InGameUpgradeViewModel {
    
    private let gameStore: GameStore
    
    var tower: Tower
    
    var cancellables: Set<AnyCancellable> = []
    
    @Resolvable<MageTowerResolver>
    init(gameStore: GameStore) {
        self.gameStore = gameStore
        self.tower = gameStore.tower
        
        gameStore.$tower.sink { [unowned self] tower in
            self.tower = tower
        }
        .store(in: &cancellables)
    }
}

// MARK: - Logic

extension InGameUpgradeViewModel {
    
    func upgrade(stat: MainStat) {
        let old = gameStore.tower.statLevel[stat] ?? 1
        gameStore.tower.statLevel[stat] = old + 1
    }
}

// MARK: - Util

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
