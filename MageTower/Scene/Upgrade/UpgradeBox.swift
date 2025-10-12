//  Created by Alexander Skorulis on 24/9/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct UpgradeBox {
    let name: String
    let value: Double
    let cost: Double
    let canAfford: Bool
    let onUpgrade: () -> Void
    let onInfo: () -> Void
}

// MARK: - Rendering

extension UpgradeBox: View {
    
    var body: some View {
        Button(action: onInfo) {
            InfoBox {
                HStack {
                    Text(name)
                        .bold()
                    Spacer()
                    upgradeButton
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var upgradeButton: some View {
        Button(action: onUpgrade) {
            VStack(spacing: 0) {
                Text(CompactNumberFormatter().string(value))
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 1)
                Text(CompactNumberFormatter().string(cost))
            }
            .background(Color.boxBackground)
            .border(Color.white)
            .padding(4)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!canAfford)
    }
}

// MARK: - Previews

#Preview {
    Grid(horizontalSpacing: 4, verticalSpacing: 4) {
        GridRow {
            UpgradeBox(
                name: "Damage",
                value: 10,
                cost: 100,
                canAfford: true,
                onUpgrade: {},
                onInfo: {},
            )
            UpgradeBox(
                name: "Health",
                value: 5100,
                cost: 1000,
                canAfford: true,
                onUpgrade: {},
                onInfo: {},
            )
        }
        
        GridRow {
            UpgradeBox(
                name: "Damage",
                value: 5100,
                cost: 1000,
                canAfford: true,
                onUpgrade: {},
                onInfo: {},
            )
            UpgradeBox(
                name: "Health",
                value: 5100,
                cost: 3000,
                canAfford: false,
                onUpgrade: {},
                onInfo: {},
            )
        }
    }
}

