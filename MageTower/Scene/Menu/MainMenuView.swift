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
        PageLayout(
            titleBar: { header },
            content: { content },
            footer: { EmptyView() }
        )
    }
    
    private var header: some View {
        TitleBar(title: "Main Menu")
    }
    
    private var content: some View {
        VStack {
            Button(action: viewModel.start) {
                Text("Start")
            }
            
            if let bestWave = viewModel.bestWaveForCurrentLevel {
                Text("Best Wave: \(bestWave)")
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
            }
            
            StepperPicker(
                value: $viewModel.level,
                options: Level.allCases) {
                    Text("\($0.description)")
            }
            .foregroundStyle(Color.black)
            
            Button(action: viewModel.showLevelCharts) {
                Text("Level Charts")
            }
            
            Button(action: viewModel.showStatCharts) {
                Text("Stat Charts")
            }
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    MainMenuView(viewModel: assembler.resolver.mainMenuViewModel(coordinator: nil))
}

