//  Created by Alexander Skorulis on 24/9/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct UpgradeBox {
    let name: String
    let value: Double
    let cost: Double
}

// MARK: - Rendering

extension UpgradeBox: View {
    
    var body: some View {
        InfoBox {
            HStack {
                Text(name)
                Spacer()
                VStack {
                    Text(CompactNumberFormatter().string(value))
                    Text(CompactNumberFormatter().string(cost))
                }
            }
        }
    }
}

// MARK: - Previews

#Preview {
    Grid(horizontalSpacing: 4, verticalSpacing: 4) {
        GridRow {
            UpgradeBox(name: "Damage", value: 10, cost: 100)
            UpgradeBox(name: "Health", value: 5100, cost: 1000)
        }
        
        GridRow {
            UpgradeBox(name: "Damage", value: 5100, cost: 1000)
            UpgradeBox(name: "Health", value: 5100, cost: 3000)
        }
    }
}

