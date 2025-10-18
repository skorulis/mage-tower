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
            
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    WorkShopView(viewModel: assembler.resolver.workShopViewModel())
}

