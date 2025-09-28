//Created by Alexander Skorulis on 27/9/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct TowerStatsBox {
    let currentHealth: Double
    let maxHealth: Double
    let damage: Double
    let xp: Double
    
    private static let formatter = CompactNumberFormatter()
}

// MARK: - Rendering

extension TowerStatsBox: View {
    
    var body: some View {
        InfoBox {
            VStack(alignment: .leading) {
                HealthBar(
                    currentHealth: currentHealth,
                    maxHealth: maxHealth
                )
                HStack(alignment: .center) {
                    VStack {
                        Text("❤️")
                        Text(Self.formatter.string(maxHealth))
                    }
                    VStack {
                        Text("🗡️")
                        Text(Self.formatter.string(damage))
                    }
                    
                    VStack {
                        Text("⚡")
                        Text(Self.formatter.string(xp))
                    }
                }
            }
        }
    }

}

// MARK: - Previews

#Preview {
    TowerStatsBox(
        currentHealth: 50,
        maxHealth: 100,
        damage: 1260,
        xp: 10003,
    )
}

