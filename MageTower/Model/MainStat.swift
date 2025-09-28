//  Created by Alexander Skorulis on 24/9/2025.

import Foundation

enum MainStat: String, CaseIterable {
    case health
    case damage
    
    func value(level: Int) -> Double {
        return baseValue * pow(Double(level), growthFactor)
    }
    
    var growthFactor: Double {
        switch self {
        case .health:
            return 1.01
        case .damage:
            return 1.01
        }
    }
    
    var baseValue: Double {
        switch self {
        case .health:
            return 10
        case .damage:
            return 10
        }
    }
}
