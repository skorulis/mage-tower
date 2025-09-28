//Created by Alexander Skorulis on 27/9/2025.

import Foundation

struct Tower {
    var statLevel: [MainStat: Int] = [:]
    var xp: Double = 0
    var currentHealth: Double = 0
    
    func level(_ stat: MainStat) -> Int {
        return statLevel[stat] ?? 1
    }
    
    func value(_ stat: MainStat) -> Double {
        return stat.value(level: level(stat))
    }
    
    func cost(_ stat: MainStat) -> Double {
        return stat.cost(level: level(stat))
    }
}
