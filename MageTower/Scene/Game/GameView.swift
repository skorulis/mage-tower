//  Created by Alexander Skorulis on 12/9/2025.

import ASKCoordinator
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
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                SpriteView(scene: viewModel.scene)
                    .ignoresSafeArea()
                    .readSize(size: $viewModel.sceneSize)
                buttonOverlay
            }
            upgrades
        }
        .dialog(item: $viewModel.dialog) {
            switch $0 {
            case .statistics:
                InGameStatsView(stats: viewModel.statistics)
            case .finish:
                EndOfRoundDialog(
                    wave: viewModel.wave,
                    onFinish: { viewModel.coordinator?.pop() }
                )
            case .statDetails(let stat):
                MainStatDetailsDialog(stat: stat)
            }
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
                Text("👻: \(animaString)")
                    .foregroundStyle(Color.white)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    private var animaString: String {
        CompactNumberFormatter().string(viewModel.persistentStore.wallet.amount(.anima))
    }
    
    private var bottomButtons: some View {
        VStack {
            HStack {
                SpeedAdjuster(speed: $viewModel.speed)
                Spacer()
                Button(action: viewModel.showStats) {
                    InfoBox {
                        Image(systemName: "tray.full.fill")
                    }
                }
            }
            
            Grid(horizontalSpacing: 8) {
                GridRow {
                    TowerStatsBox(
                        currentHealth: viewModel.tower.currentHealth,
                        maxHealth: viewModel.tower.value(.health),
                        damage: viewModel.tower.value(.damage),
                        xp: viewModel.wallet.aether,
                    )
                    WaveProgressBox(
                        wave: viewModel.wave,
                        levelParams: viewModel.gameStore.levelParameters
                    )
                }
            }
            
        }
    }
    
    private var upgrades: some View {
        InGameUpgradeView(viewModel: viewModel.upgradeViewModel)
            .background(Color.black)
    }
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    GameView(viewModel: assembler.resolver.gameViewModel())
}

