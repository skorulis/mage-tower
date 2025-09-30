//  Created by Alexander Skorulis on 13/9/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct WaveProgressBox {
    let wave: Wave
    let levelParams: LevelParameters
}

// MARK: - Rendering

extension WaveProgressBox: View {
    
    var body: some View {
        InfoBox {
            VStack(alignment: .leading) {
                Text("❤️ \(enemyHealth)")
                Text("🗡️ \(enemyDamage)")
                Text("Wave \(wave.number)")
                progress
            }
        }
    }
    
    private var enemyHealth: String {
        let value = levelParams.health(wave: wave.number)
        return CompactNumberFormatter().string(value)
    }
    
    private var enemyDamage: String {
        let value = levelParams.damage(wave: wave.number)
        return CompactNumberFormatter().string(value)
    }
    
    private var progress: some View {
        ProgressBar(value: progressValue, color: .red)
    }
    
    private var progressValue: CGFloat {
        CGFloat(wave.time) / CGFloat(wave.duration)
    }
}

// MARK: - Previews

#Preview {
    WaveProgressBox(
        wave: .init(number: 10, time: 2, duration: 10),
        levelParams: Level.one.params
    )
    
    WaveProgressBox(
        wave: .init(number: 160, time: 2, duration: 10),
        levelParams: Level.one.params
    )
}

