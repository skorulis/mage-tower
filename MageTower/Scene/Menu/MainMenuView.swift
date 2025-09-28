//Created by Alexander Skorulis on 28/9/2025.

import Foundation
import Knit
import SwiftUI

// MARK: - Memory footprint

@MainActor struct MainMenuView {
    @State var viewModel: MainMenuViewModel
}

// MARK: - Rendering

extension MainMenuView: View {
    
    var body: some View {
        PageLayout(titleBar: { header }, content: { content }, footer: { EmptyView() })
    }
    
    private var header: some View {
        Text("Main Menu")
    }
    
    private var content: some View {
        VStack {
            Button(action: viewModel.start) {
                Text("Start")
            }
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    MainMenuView(viewModel: assembler.resolver.mainMenuViewModel())
}

