//Created by Alexander Skorulis on 27/9/2025.

import Foundation

struct Tower {
    var statLevel: [MainStat: Int] = [:]
    
    func level(_ stat: MainStat) -> Int {
        return statLevel[stat] ?? 1
    }
    
    func value(_ stat: MainStat) -> Double {
        return stat.value(level: level(stat))
    }
}
