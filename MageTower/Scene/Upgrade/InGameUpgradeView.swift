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
            tabs
            Color.clear
                .frame(height: 1)
        }
        .animation(.default, value: viewModel.isOpen)
    }
    
    private func row(items: [MainStat]) -> some View {
        GridRow {
            Button(action: { viewModel.upgrade(stat: items[0]) }) {
                UpgradeBox(
                    name: items[0].rawValue,
                    value: viewModel.tower.value(items[0]),
                    cost: viewModel.tower.cost(items[0]),
                )
            }
            .disabled(!viewModel.canAfford(stat: items[0]))
            
            if items.count > 1 {
                Button(action: { viewModel.upgrade(stat: items[1]) }) {
                    UpgradeBox(
                        name: items[1].rawValue,
                        value: viewModel.tower.value(items[1]),
                        cost: viewModel.tower.cost(items[1]),
                    )
                }
                .disabled(!viewModel.canAfford(stat: items[1]))
            }
        }
    }
    
    private var statChunks: [[MainStat]] {
        MainStat.allCases.chunked(into: 2)
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
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    VStack {
        Spacer()
        InGameUpgradeView(viewModel: assembler.resolver.inGameUpgradeViewModel())
    }
    
}

