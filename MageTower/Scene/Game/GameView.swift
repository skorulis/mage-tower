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
        ZStack(alignment: .center) {
            SpriteView(scene: viewModel.scene)
                .ignoresSafeArea()
            buttonOverlay
        }
        .navigationBarHidden(true)
    }
    
    private var buttonOverlay: some View {
        VStack {
            topBar
            Spacer()
            bottomButtons
        }
    }
    
    private var topBar: some View {
        HStack {
            VStack {
                Text("👻: \(CompactNumberFormatter().string(viewModel.upgrades.essence))")
                    .foregroundStyle(Color.white)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    private var bottomButtons: some View {
        VStack {
            SpeedAdjuster(speed: $viewModel.speed)
            Grid(horizontalSpacing: 8) {
                GridRow {
                    TowerStatsBox(
                        currentHealth: viewModel.tower.currentHealth,
                        maxHealth: viewModel.tower.value(.health),
                        damage: viewModel.tower.value(.damage),
                        xp: viewModel.tower.xp,
                    )
                    WaveProgressBox(
                        wave: viewModel.wave,
                        levelParams: viewModel.gameStore.levelParameters
                    )
                }
            }
            InGameUpgradeView(viewModel: viewModel.upgradeViewModel)
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    GameView(viewModel: assembler.resolver.gameViewModel())
}

