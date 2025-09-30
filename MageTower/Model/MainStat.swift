//  Created by Alexander Skorulis on 24/9/2025.

import Foundation

enum MainStat: String, CaseIterable, Codable {
    case health
    case damage
    case essenceConversion
    
    func value(level: Int) -> Double {
        return baseValue * pow(Double(level), growthFactor)
    }
    
    func cost(level: Int) -> Double {
        let multiplier = pow(Double(level), costGrowthFactor)
        return baseCost * multiplier
    }
    
    var growthFactor: Double {
        switch self {
        case .health:
            return 1.01
        case .damage:
            return 1.01
        case .essenceConversion:
            return 2
        }
    }
    
    var costGrowthFactor: Double {
        switch self {
        case .health:
            return 1.02
        case .damage:
            return 1.02
        case .essenceConversion:
            return 1.02
        }
    }
    
    var baseCost: Double {
        switch self {
        case .health:
            return 10
        case .damage:
            return 10
        case .essenceConversion:
            return 40
        }
    }
    
    var baseValue: Double {
        switch self {
        case .health:
            return 100
        case .damage:
            return 10
        case .essenceConversion:
            return 0.1
        }
    }
}
