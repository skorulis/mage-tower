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
    
    private let keyValueStore: PKeyValueStore
    
    private static let upgradesKey: String = "upgradesKey"
    
    @Resolvable<MageTowerResolver>
    init(keyValueStore: PKeyValueStore) {
        self.keyValueStore = keyValueStore
        self.upgrades = (try? keyValueStore.codable(forKey: Self.upgradesKey)) ?? .init()
    }
}
