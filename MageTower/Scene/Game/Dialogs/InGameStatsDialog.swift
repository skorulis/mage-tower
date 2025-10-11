//Created by Alexander Skorulis on 11/10/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct InGameStatsView {
    let stats: GameStatistics
}

// MARK: - Rendering

extension InGameStatsView: View {
    
    var body: some View {
        VStack {
            Text("Stats")
                .font(.title2)
                .fontWeight(.bold)
            
            row(name: "Kills", value: Double(stats.kills))
        }
    }
    
    private func row(name: String, value: Double) -> some View {
        HStack {
            Text(name)
                .bold()
            Spacer()
            Text(CompactNumberFormatter().string(value))
        }
    }
}

// MARK: - Previews

#Preview {
    DialogBox {
        InGameStatsView(stats: .init())
    }
}

