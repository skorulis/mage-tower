//Created by Alexander Skorulis on 4/10/2025.

import ASKCoordinator
import Foundation
import Knit
import KnitMacros
import SwiftUI

@Observable final class LevelChartsViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    
    var level: Level = .one
    
    var maxLevel: Int = 20
    
    var levelOptions: [Int] = [20, 100, 250, 500, 1000]
    
    @Resolvable<Resolver>
    init() {
        
    }
}

// MARK: - Logic

extension LevelChartsViewModel {
    
    var gap: Int {
        return max(maxLevel / 100, 1)
    }
    
    func health(wave: Int) -> Double {
        level.params.health(wave: wave)
    }
    
    var chartData: [BasicChart.ChartDataPoint] {
        stride(from: 1, through: maxLevel, by: gap).map { wave in
            BasicChart.ChartDataPoint(
                x: wave,
                y: health(wave: wave)
            )
        }
    }
    
}
