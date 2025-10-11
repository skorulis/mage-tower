//Created by Alexander Skorulis on 9/10/2025.

import ASKCoordinator
import Foundation
import Knit
import KnitMacros
import SwiftUI

@Observable final class StatChartViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    
    var stat: MainStat = .damage
    
    var maxLevel: Int = 10
    
    var levelOptions: [Int] = [10, 25, 50, 100, 250, 500, 1000]
    
    @Resolvable<Resolver>
    init() {
        
    }
}

// MARK: - Logic

extension StatChartViewModel {
    
    var gap: Int {
        return max(maxLevel / 100, 1)
    }
    
    func cost(level: Int) -> Double {
        stat.cost(level: level)
    }
    
    var chartCostData: [BasicChart.ChartDataPoint] {
        stride(from: 1, through: maxLevel, by: gap).map { level in
            BasicChart.ChartDataPoint(
                x: level,
                y: cost(level: level)
            )
        }
    }
    
    var chartValueData: [BasicChart.ChartDataPoint] {
        stride(from: 1, through: maxLevel, by: gap).map { level in
            BasicChart.ChartDataPoint(
                x: level,
                y: stat.value(level: level)
            )
        }
    }
}
