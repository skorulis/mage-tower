//Created by Alexander Skorulis on 27/9/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct TowerStatsBox {
    let health: Double
    let damage: Double
    
    private static let formatter = CompactNumberFormatter()
}

// MARK: - Rendering

extension TowerStatsBox: View {
    
    
    
    var body: some View {
        InfoBox {
            VStack(alignment: .leading) {
                Text("❤️ \(Self.formatter.string(health))")
                Text("🗡️ \(Self.formatter.string(damage))")
            }
        }
    }
}

// MARK: - Previews

#Preview {
    TowerStatsBox(
        health: 100,
        damage: 1260,
    )
}

