//  Created by Alexander Skorulis on 24/9/2025.

import Foundation

enum MainStat: String, CaseIterable, Codable {
    case health
    case damage
    case essenceConversion
    
    func value(level: Int) -> Double {
        ScalingFunctions.linear(
            base: baseValue,
            multiplier: growthFactor,
            level: level
        )
    }
    
    func cost(level: Int) -> Double {
        ScalingFunctions.exponential(
            base: baseCost,
            rate: costGrowthFactor,
            level: level
        )
    }
    
    var growthFactor: Double {
        switch self {
        case .health:
            return 1.25
        case .damage:
            return 1.25
        case .essenceConversion:
            return 1.25
        }
    }
    
    var costGrowthFactor: Double {
        switch self {
        case .health:
            return 0.2
        case .damage:
            return 0.2
        case .essenceConversion:
            return 0.5
        }
    }
    
    var name: String {
        switch self {
        case .health:
            return "Health"
        case .damage:
            return "Damage"
        case .essenceConversion:
            return "Essence Conversion"
        }
    }
    
    var description: String {
        switch self {
        case .health:
            return "Increase base health"
        case .damage:
            return "Increase base damage"
        case .essenceConversion:
            return "Conversion of XP to essence"
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
