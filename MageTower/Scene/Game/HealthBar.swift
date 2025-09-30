//Created by Alexander Skorulis on 28/9/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct HealthBar {
    let currentHealth: Double
    let maxHealth: Double
    
    private static let formatter = CompactNumberFormatter()
}

// MARK: - Rendering

extension HealthBar: View {
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                bar(geometry)
                text
            }   
        }
        .frame(height: 20)
        .cornerRadius(2)
    }
    
    private func bar(_ geometry: GeometryProxy) -> some View {
        ZStack(alignment: .leading) {
            // Background bar
            Rectangle()
                .fill(Color.blue.opacity(0.3))
            
            // Foreground progress bar
            Rectangle()
                .fill(Color.green)
                .frame(width: geometry.size.width * healthFraction)
        }
    }
    
    private var text: some View {
        let s1 = Self.formatter.string(currentHealth)
        let s2 = Self.formatter.string(maxHealth)
        
        return Text("\(s1) / \(s2)")
            .font(.footnote)
    }
    
    private var healthFraction: Double {
        return max(currentHealth / maxHealth, 0)
    }
}

// MARK: - Previews

#Preview {
    VStack {
        HealthBar(
            currentHealth: 100,
            maxHealth: 100,
        )
        HealthBar(
            currentHealth: 250,
            maxHealth: 1000,
        )
        HealthBar(
            currentHealth: 23350,
            maxHealth: 400000,
        )
    }
    .padding()
    
}

