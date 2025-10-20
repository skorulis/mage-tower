//Created by Alexander Skorulis on 19/10/2025.

import Combine
import Foundation
import Knit
import KnitMacros
import SwiftUI

@Observable final class MainStatDetailsDialogViewModel {
    
    let stat: MainStat
    var tower: Tower
    
    var cancellables: Set<AnyCancellable> = []
    
    init(
        stat: MainStat,
        towerProvider: TowerProvider,
    ) {
        self.stat = stat
        self.tower = towerProvider.tower
        
        towerProvider.towerPublisher.sink { [unowned self] in
            self.tower = $0
        }
        .store(in: &cancellables)
    }
}

// MARK: - Logic

extension MainStatDetailsDialogViewModel {}
