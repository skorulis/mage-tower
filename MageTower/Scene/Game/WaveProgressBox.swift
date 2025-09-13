//  Created by Alexander Skorulis on 13/9/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct WaveProgressBox {
    let wave: Wave
}

// MARK: - Rendering

extension WaveProgressBox: View {
    
    var body: some View {
        InfoBox {
            VStack(alignment: .leading) {
                Text("Wave \(wave.number)")
                progress
            }
        }
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
        wave: .init(number: 100, time: 2, duration: 10)
    )
}

