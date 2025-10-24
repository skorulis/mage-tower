//Created by Alexander Skorulis on 28/9/2025.

import ASKCore
import Combine
import Foundation
import Knit
import KnitMacros

/// Data that survives between games
final class PersistentStore: ObservableObject, TowerProvider {
    @Published var upgrades: GameUpgrades {
        didSet {
            try? keyValueStore.set(codable: upgrades, forKey: Self.upgradesKey)
        }
    }
    
    @Published var wallet: Wallet {
        didSet {
            try? keyValueStore.set(codable: wallet, forKey: Self.walletKey)
        }
    }
    
    /// Initial tower setup before starting the round
    @Published var tower: Tower {
        didSet {
            try? keyValueStore.set(codable: tower, forKey: Self.towerKey)
        }
    }
    
    @Published var levelRecords: LevelRecords {
        didSet {
            try? keyValueStore.set(codable: levelRecords, forKey: Self.recordsKey)
        }
    }
    
    var towerPublisher: Published<Tower>.Publisher { $tower }
    
    private let keyValueStore: PKeyValueStore

    @Resolvable<MageTowerResolver>
    init(keyValueStore: PKeyValueStore) {
        self.keyValueStore = keyValueStore
        self.upgrades = (try? keyValueStore.codable(forKey: Self.upgradesKey)) ?? .init()
        self.wallet = (try? keyValueStore.codable(forKey: Self.walletKey)) ?? .init()
        self.tower = (try? keyValueStore.codable(forKey: Self.towerKey)) ?? .init()
        self.levelRecords = (try? keyValueStore.codable(forKey: Self.recordsKey)) ?? .init(levels: [:])
    }
    
    func updateLevelRecord(
        level: Level,
        wave: Int,
        income: [Currency: Double]
    ) {
        let record = LevelRecord(
            bestWave: wave,
            bestIncome: income
        )
        levelRecords.levels[level] = record.merge(other: levelRecords.levels[level])
    }
    
    
}

// MARK: - Keys

extension PersistentStore {
    private static let upgradesKey: String = "upgradesKey"
    private static let walletKey: String = "walletKey"
    private static let towerKey: String = "towerKey"
    private static let recordsKey: String = "recordsKey"
}
