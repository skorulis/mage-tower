//Created by Alexander Skorulis on 27/9/2025.

import Combine
import Foundation

struct Tower: Codable {
    var statLevel: [MainStat: Int] = [:]
    var currentHealth: Double = 0
    
    var range: CGFloat { 200 }
    
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

protocol TowerProvider {
    var tower: Tower { get set }
    var towerPublisher: Published<Tower>.Publisher { get }
}
