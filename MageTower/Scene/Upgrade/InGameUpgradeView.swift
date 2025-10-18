//  Created by Alexander Skorulis on 24/9/2025.

import Foundation
import Knit
import SwiftUI

// MARK: - Memory footprint

@MainActor struct InGameUpgradeView {
    @State var viewModel: InGameUpgradeViewModel
}

// MARK: - Rendering

extension InGameUpgradeView: View {
    
    var body: some View {
        VStack {
            if viewModel.isOpen {
                TowerUpgradeView(
                    currency: .aether,
                    tower: towerBinding,
                    wallet: walletBinding,
                    onInfoPress: { viewModel.showInfo($0) }
                )
            }
            tabs
            Color.clear
                .frame(height: 1)
        }
        .animation(.default, value: viewModel.isOpen)
    }
    
    private var tabs: some View {
        HStack {
            Button(action: { viewModel.isOpen.toggle() }) {
                InfoBox {
                    Text("Toggle")
                }
            }
        }
    }
    
    var towerBinding: Binding<Tower> {
        Binding<Tower>(
            get: { viewModel.tower },
            set: { viewModel.gameStore.tower = $0 }
        )
    }
    
    var walletBinding: Binding<Wallet> {
        Binding<Wallet>(
            get: { viewModel.wallet },
            set: { viewModel.gameStore.wallet = $0 }
        )
    }
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    VStack {
        Spacer()
        InGameUpgradeView(viewModel: assembler.resolver.inGameUpgradeViewModel())
    }
    
}

