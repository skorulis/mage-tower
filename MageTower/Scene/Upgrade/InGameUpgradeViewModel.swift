//  Created by Alexander Skorulis on 24/9/2025.

import ASKCoordinator
import Combine
import Foundation
import KnitMacros

@Observable final class InGameUpgradeViewModel {
    
    var coordinator: ASKCoordinator.Coordinator?
    
    let gameStore: GameStore
    
    var isOpen: Bool = true
    
    var tower: Tower
    var wallet: Wallet
    
    var cancellables: Set<AnyCancellable> = []
    
    @Resolvable<MageTowerResolver>
    init(gameStore: GameStore) {
        self.gameStore = gameStore
        self.tower = gameStore.tower
        self.wallet = gameStore.wallet
        
        gameStore.$tower.sink { [unowned self] tower in
            self.tower = tower
        }
        .store(in: &cancellables)
        
        gameStore.$wallet.sink { [unowned self] wallet in
            self.wallet = wallet
        }
        .store(in: &cancellables)
    }
}

// MARK: - Logic

extension InGameUpgradeViewModel {
    
    func showInfo(_ stat: MainStat) {
        coordinator?.custom(overlay: .dialog, GameDialogPath.mainStatDetails(stat: stat, inGame: false))
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
