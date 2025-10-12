//Created by Alexander Skorulis on 12/10/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct MainStatDetailsDialog {
    let stat: MainStat
}

// MARK: - Rendering

extension MainStatDetailsDialog: View {
    
    var body: some View {
        VStack {
            Text(stat.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(stat.description)
        }
    }
}

// MARK: - Previews

#Preview {
    DialogBox {
        MainStatDetailsDialog(stat: .health)
    }
}

