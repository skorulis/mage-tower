//  Created by Alexander Skorulis on 13/9/2025.

import Foundation

enum Level {
    case one
    
    var params: LevelParameters {
        switch self {
        case .one:
            return LevelParamsLibrary.one
        }
    }
}

struct LevelParameters {
    let spawnRate: Double
    let spawnRateChange: Double
    
    var waveDuration: TimeInterval { 20 }
}

enum LevelParamsLibrary {
    static var one: LevelParameters {
        LevelParameters(
            spawnRate: 1,
            spawnRateChange: 0.01,
        )
    }
}
