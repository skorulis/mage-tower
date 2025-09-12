//  Created by Alexander Skorulis on 12/9/2025.

import Foundation
import SpriteKit
import Knit
import SwiftUI

// MARK: - Memory footprint

@MainActor struct GameView {
    @State var viewModel: GameViewModel
}

// MARK: - Rendering

extension GameView: View {
    
    var body: some View {
        SpriteView(scene: viewModel.scene)
            .ignoresSafeArea()
    }
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    GameView(viewModel: assembler.resolver.gameViewModel())
}

