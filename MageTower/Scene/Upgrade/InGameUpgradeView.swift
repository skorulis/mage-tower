//  Created by Alexander Skorulis on 24/9/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct InGameUpgradeView {
    @State var viewModel: InGameUpgradeViewModel
}

// MARK: - Rendering

extension InGameUpgradeView: View {
    
    var body: some View {
        Grid {
            ForEach(statChunks.indices, id: \.self) { index in
                row(items: statChunks[index])
            }
        }
    }
    
    private func row(items: [MainStat]) -> some View {
        GridRow {
            Button(action: { viewModel.upgrade(stat: items[0]) }) {
                UpgradeBox(
                    name: items[0].rawValue,
                    value: viewModel.tower.value(items[0])
                )
            }
            
            if items.count > 1 {
                Button(action: { viewModel.upgrade(stat: items[1]) }) {
                    UpgradeBox(
                        name: items[1].rawValue,
                        value: viewModel.tower.value(items[1])
                    )
                }
            }
        }
    }
    
    private var statChunks: [[MainStat]] {
        MainStat.allCases.chunked(into: 2)
    }
}

// MARK: - Previews

//#Preview {
//    let assembler = MageTowerAssembly.testing()
//    InGameUpgradeView(viewModel: assembler.inGameUpgradeViewModel())
//}
//
