//Created by Alexander Skorulis on 4/10/2025.

import ASKCoordinator
import Foundation
import Knit
import KnitMacros
import SwiftUI

@Observable final class LevelChartsViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    
    var level: Level = .one
    
    var maxLevel: WaveNumber = .`20`
    
    @Resolvable<Resolver>
    init() {
        
    }
}

// MARK: - Inner Types

extension LevelChartsViewModel {
    enum WaveNumber: Int, CaseIterable {
        case `20` = 20
        case `100` = 100
        case `250` = 250
        case `500` = 500
        case `1000` = 1000
        
        var gap: Int {
            return max(rawValue / 100, 1)
        }
    }
}

// MARK: - Logic

extension LevelChartsViewModel {
    
    func health(wave: Int) -> Double {
        level.params.health(wave: wave)
    }
    
    var chartData: [ChartDataPoint] {
        stride(from: 1, through: maxLevel.rawValue, by: maxLevel.gap).map { wave in
            ChartDataPoint(
                wave: wave,
                health: health(wave: wave)
            )
        }
    }
    
}
