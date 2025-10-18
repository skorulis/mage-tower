//Created by Alexander Skorulis on 28/9/2025.

import ASKCore
import Combine
import Foundation
import Knit
import KnitMacros

/// Data that survives between games
final class PersistentStore: ObservableObject {
    @Published var upgrades: GameUpgrades {
        didSet {
            try? keyValueStore.set(codable: upgrades, forKey: Self.upgradesKey)
        }
    }
    
    @Published var wallet: Wallet
    
    private let keyValueStore: PKeyValueStore
        
    @Resolvable<MageTowerResolver>
    init(keyValueStore: PKeyValueStore) {
        self.keyValueStore = keyValueStore
        self.upgrades = (try? keyValueStore.codable(forKey: Self.upgradesKey)) ?? .init()
        self.wallet = (try? keyValueStore.codable(forKey: Self.walletKey)) ?? .init()
    }
}

// MARK: - Keys

extension PersistentStore {
    private static let upgradesKey: String = "upgradesKey"
    private static let walletKey: String = "walletKey"
}
