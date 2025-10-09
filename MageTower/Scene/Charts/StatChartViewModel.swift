//Created by Alexander Skorulis on 9/10/2025.

import ASKCoordinator
import Foundation
import Knit
import KnitMacros
import SwiftUI

@Observable final class StatChartViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    
    var stat: MainStat = .damage
    
    var maxLevel: StatLevel = .`10`
    
    @Resolvable<Resolver>
    init() {
        
    }
}

// MARK: - Inner Types

extension StatChartViewModel {
    enum StatLevel: Int, CaseIterable {
        case `10` = 10
        case `25` = 25
        case `50` = 50
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

extension StatChartViewModel {
    
    func cost(level: Int) -> Double {
        stat.cost(level: level)
    }
    
    var chartCostData: [ChartDataPoint] {
        stride(from: 1, through: maxLevel.rawValue, by: maxLevel.gap).map { level in
            ChartDataPoint(
                wave: level,
                health: cost(level: level)
            )
        }
    }
}
