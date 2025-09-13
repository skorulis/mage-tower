//  Created by Alexander Skorulis on 13/9/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct WaveProgressBox {
    let waveNumber: Int
    let waveProgression: TimeInterval
    let waveDuration: TimeInterval
}

// MARK: - Rendering

extension WaveProgressBox: View {
    
    var body: some View {
        InfoBox {
            VStack(alignment: .leading) {
                Text("Wave \(waveNumber)")
                progress
            }
        }
    }
    
    private var progress: some View {
        ProgressBar(value: progressValue, color: .red)
    }
    
    private var progressValue: CGFloat {
        CGFloat(waveProgression) / CGFloat(waveDuration)
    }
}

// MARK: - Previews

#Preview {
    WaveProgressBox(
        waveNumber: 100,
        waveProgression: 3,
        waveDuration: 10
    )
}

