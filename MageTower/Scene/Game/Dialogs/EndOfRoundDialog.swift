//Created by Alexander Skorulis on 11/10/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct EndOfRoundDialog {
    let wave: Wave
    let onFinish: () -> Void
}

// MARK: - Rendering

extension EndOfRoundDialog: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Game Stats")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Wave \(wave.number)")
                .font(.title3)
                .fontWeight(.bold)
            
            Text("There will be some more details in here at some point in the future")
            
            HStack {
                Button("Ok") {
                    onFinish()
                }
            }
        }
    }
}

// MARK: - Previews

#Preview {
    DialogBox {
        EndOfRoundDialog(
            wave: .init(number: 600, time: 0, duration: 0),
            onFinish: {}
        )
    }
    
}

