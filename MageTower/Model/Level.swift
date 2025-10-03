//  Created by Alexander Skorulis on 13/9/2025.

import Foundation

enum Level: CaseIterable, CustomStringConvertible {
    case one
    case two
    case three
    
    var params: LevelParameters {
        switch self {
        case .one:
            return LevelParamsLibrary.one
        case .two:
            return LevelParamsLibrary.one
        case .three:
            return LevelParamsLibrary.one
        }
    }
    
    var description: String {
        switch self {
        case .one:
            return "Level 1"
        case .two:
            return "Level 2"
        case .three:
            return "Level 3"
        }
    }
}

struct LevelParameters {
    let spawnRate: Double
    let spawnRateChange: Double
    
    let baseHealth: Double
    let healthIncrease: Double
    
    let baseDamage: Double
    let damageIncrease: Double
    
    var waveDuration: TimeInterval { 20 }
    var enemyCap: Int { 50 }
    var xpMultiplier: Double { 1 }
    
    func health(wave: Int) -> Double {
        baseHealth * pow(1 + healthIncrease, Double(wave))
    }
    
    func damage(wave: Int) -> Double {
        baseDamage * pow(1 + damageIncrease, Double(wave))
    }
}

enum LevelParamsLibrary {
    static var one: LevelParameters {
        LevelParameters(
            spawnRate: 1,
            spawnRateChange: 0.01,
            baseHealth: 2,
            healthIncrease: 0.2,
            baseDamage: 2,
            damageIncrease: 0.1,
        )
    }
}
