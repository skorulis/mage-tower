//  Created by Alexander Skorulis on 24/9/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct UpgradeBox {
    let name: String
    let value: Double
}

// MARK: - Rendering

extension UpgradeBox: View {
    
    var body: some View {
        InfoBox {
            HStack {
                Text(name)
                Spacer()
                Text(CompactNumberFormatter().string(value))
            }
        }
    }
}

// MARK: - Previews

#Preview {
    Grid(horizontalSpacing: 4, verticalSpacing: 4) {
        GridRow {
            UpgradeBox(name: "Damage", value: 10)
            UpgradeBox(name: "Health", value: 5100)
        }
        
        GridRow {
            UpgradeBox(name: "Damage", value: 5100)
            UpgradeBox(name: "Health", value: 5100)
        }
    }
}

