//Created by Alexander Skorulis on 12/10/2025.

import Foundation
import Knit
import SwiftUI

// MARK: - Memory footprint

@MainActor struct MainStatDetailsDialog {
    @State var viewModel: MainStatDetailsDialogViewModel
}

// MARK: - Rendering

extension MainStatDetailsDialog: View {
    
    var body: some View {
        VStack {
            Text(viewModel.stat.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text("level: \(viewModel.tower.level(viewModel.stat))")
            
            Text(viewModel.stat.description)
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    DialogBox {
        MainStatDetailsDialog(
            viewModel: assembler.resolver.mainStatDetailsDialogViewModel(
                stat: .health,
                inGame: false,
            )
        )
    }
}

