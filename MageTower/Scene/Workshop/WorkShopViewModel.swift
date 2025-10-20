//Created by Alexander Skorulis on 18/10/2025.

import ASKCoordinator
import Combine
import Foundation
import Knit
import KnitMacros
import SwiftUI

@Observable final class WorkShopViewModel {
    
    var coordinator: ASKCoordinator.Coordinator?
    
    let persistentStore: PersistentStore
    
    var tower: Tower
    var wallet: Wallet
    var cancellables: Set<AnyCancellable> = []
    
    @Resolvable<MageTowerResolver>
    init(@Argument coordinator: ASKCoordinator.Coordinator?, persistentStore: PersistentStore) {
        self.tower = persistentStore.tower
        self.wallet = persistentStore.wallet
        self.persistentStore = persistentStore
        self.coordinator = coordinator
        
        persistentStore.$tower.sink { [unowned self] tower in
            self.tower = tower
        }
        .store(in: &cancellables)
        
        persistentStore.$wallet.sink { [unowned self] wallet in
            self.wallet = wallet
        }
        .store(in: &cancellables)
    }
    
}

// MARK: - Logic

extension WorkShopViewModel {
    func showInfo(_ stat: MainStat) {
        coordinator?.custom(overlay: .dialog, GameDialogPath.mainStatDetails(stat: stat, inGame: false))
    }
}
