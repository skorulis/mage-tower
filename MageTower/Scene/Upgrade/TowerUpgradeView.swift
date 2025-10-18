//Created by Alexander Skorulis on 18/10/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct TowerUpgradeView {
    let currency: Currency
    @Binding var tower: Tower
    @Binding var wallet: Wallet
    let onInfoPress: (MainStat) -> ()
}

// MARK: - Rendering

extension TowerUpgradeView: View {
    
    var body: some View {
        Grid {
            ForEach(statChunks.indices, id: \.self) { index in
                row(items: statChunks[index])
            }
        }
        .transition(
            AnyTransition
                .move(edge: .bottom)
                .combined(with: .opacity)
        )
    }
    
    private func row(items: [MainStat]) -> some View {
        GridRow {
            upgradeBox(item: items[0])
            
            if items.count > 1 {
                upgradeBox(item: items[1])
            }
        }
    }
    
    private func upgradeBox(item: MainStat) -> some View {
        UpgradeBox(
            name: item.rawValue,
            value: tower.value(item),
            cost: tower.cost(item),
            canAfford: canAfford(stat: item),
            onUpgrade: { upgrade(stat: item) },
            onInfo: { onInfoPress(item) }
        )
    }
    
    private var statChunks: [[MainStat]] {
        MainStat.allCases.chunked(into: 2)
    }
    
    private func canAfford(stat: MainStat) -> Bool {
        let cost = stat.cost(level: tower.level(stat))
        return wallet.amount(.aether) >= cost
    }
    
    private func upgrade(stat: MainStat) {
        guard canAfford(stat: stat) else { return }
        let cost = stat.cost(level: tower.level(stat))
        let old = tower.statLevel[stat] ?? 1
        tower.statLevel[stat] = old + 1
        wallet.add(currency: .aether, amount: -cost)
    }
}

// MARK: - Previews

#Preview {
    @Previewable @State var tower: Tower = .init()
    @Previewable @State var wallet: Wallet = .init(
        amounts: [.aether: 400]
    )
    
    TowerUpgradeView(
        currency: .aether,
        tower: $tower,
        wallet: $wallet,
        onInfoPress: { _ in }
    )
}

