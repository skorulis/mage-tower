//Created by Alexander Skorulis on 28/9/2025.

import Foundation

struct GameUpgrades: Codable {
    
    // Essence left to spend
    var essence: Double = 0
    
    var upgrades: [MainStat: Int] = [:]
}
