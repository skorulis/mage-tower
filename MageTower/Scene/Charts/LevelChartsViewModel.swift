//Created by Alexander Skorulis on 4/10/2025.

import ASKCoordinator
import Foundation
import Knit
import KnitMacros
import SwiftUI

@Observable final class LevelChartsViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    
    var level: Level = .one
    
    @Resolvable<Resolver>
    init() {
        
    }
}

// MARK: - Logic

extension LevelChartsViewModel {
    
    var chartData: [ChartDataPoint] {
        // Dummy data for now - you can replace this with real data later
        (1...20).map { wave in
            ChartDataPoint(
                wave: wave,
                health: Double.random(in: 10...50) // Dummy health values
            )
        }
    }
    
}
