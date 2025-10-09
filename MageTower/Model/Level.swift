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
            return LevelParamsLibrary.two
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
    let healthIncreaseLinear: Double
    let healthIncreaseExponential: Double
    
    let baseDamage: Double
    let damageIncrease: Double
    
    var waveDuration: TimeInterval { 20 }
    var enemyCap: Int { 50 }
    var xpMultiplier: Double { 1 }
    
    func health(wave: Int) -> Double {
        // For the first 100 waves, use linear increase, then blend into exponential
        if wave <= 100 {
            return baseHealth + Double(wave) * (baseHealth * healthIncreaseLinear)
        } else {
            // Calculate health at wave 100 using linear formula
            let linearHealth = baseHealth + 100 * (baseHealth * healthIncreaseLinear)
            // Calculate what the exponential would be at wave 100
            let expAt100 = baseHealth * pow(1 + healthIncreaseExponential, 100)
            // Find a multiplier to blend smoothly from linear to exponential
            let blendMultiplier = linearHealth / expAt100
            // Use exponential for wave > 100, scaled so it's continuous at wave 100
            return blendMultiplier * baseHealth * pow(1 + healthIncreaseExponential, Double(wave))
        }
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
            healthIncreaseLinear: 0.2,
            healthIncreaseExponential: 0.02,
            baseDamage: 2,
            damageIncrease: 0.1,
        )
    }
    
    static var two: LevelParameters {
        LevelParameters(
            spawnRate: 1,
            spawnRateChange: 0.01,
            baseHealth: 10,
            healthIncreaseLinear: 0.2,
            healthIncreaseExponential: 0.02,
            baseDamage: 2,
            damageIncrease: 0.1,
        )
    }
}
