//Created by Alexander Skorulis on 18/10/2025.

import Foundation
import Knit
import SwiftUI

// MARK: - Memory footprint

@MainActor struct WorkShopView {
    
    @State var viewModel: WorkShopViewModel
    
}

// MARK: - Rendering

extension WorkShopView: View {
    
    var body: some View {
        PageLayout {
            titleBar
        } content: {
            content
        }
    }
    
    private var titleBar: some View {
        TitleBar(title: "WorkShop")
    }
    
    private var content: some View {
        VStack {
            TowerUpgradeView(
                currency: .anima,
                tower: towerBinding,
                wallet: walletBinding,
                onInfoPress: { viewModel.showInfo($0) }
            )
        }
    }
    
    var towerBinding: Binding<Tower> {
        Binding<Tower>(
            get: { viewModel.tower },
            set: { viewModel.persistentStore.tower = $0 }
        )
    }
    
    var walletBinding: Binding<Wallet> {
        Binding<Wallet>(
            get: { viewModel.wallet },
            set: { viewModel.persistentStore.wallet = $0 }
        )
    }
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    WorkShopView(viewModel: assembler.resolver.workShopViewModel(coordinator: nil))
}

