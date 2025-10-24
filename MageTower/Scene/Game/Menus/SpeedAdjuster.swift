//Created by Alexander Skorulis on 30/9/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct SpeedAdjuster {
    @Binding var speed: Double
}

// MARK: - Rendering

extension SpeedAdjuster: View {
    
    var body: some View {
        HStack(spacing: 8) {
            buttonDown
            Text("\(speed, specifier: "%.1f")")
            buttonUp
        }
        .foregroundStyle(Color.white)
    }
    
    private var buttonUp: some View {
        Button(action: increase) {
            InfoBox {
                Image(systemName: "arrow.up")
            }
        }
    }
    
    private var buttonDown: some View {
        Button(action: decrease) {
            InfoBox {
                Image(systemName: "arrow.down")
            }
        }
    }
    
    private func decrease() {
        speed = max(speed - 0.5, 1)
    }
    
    private func increase() {
        speed = min(speed + 0.5, 6)
    }
}

// MARK: - Previews

#Preview {
    @Previewable @State var speed: Double = 1
    SpeedAdjuster(speed: $speed)
        .padding(16)
        .background(Color.black)
}

