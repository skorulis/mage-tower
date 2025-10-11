//Created by Alexander Skorulis on 4/10/2025.

import ASKCoordinator
import Charts
import Foundation
import Knit
import SwiftUI

// MARK: - Memory footprint

@MainActor struct LevelChartsView {
    @State var viewModel: LevelChartsViewModel
}

// MARK: - Rendering

extension LevelChartsView: View {
    
    var body: some View {
        PageLayout {
            titleBar
        } content: {
            content
        }
    }
    
    private var titleBar: some View {
        TitleBar(
            title: "Level Charts",
            backAction: { viewModel.coordinator?.pop() }
        )
    }
    
    private var content: some View {
        VStack {
            StepperPicker(
                value: $viewModel.level,
                options: Level.allCases) {
                    Text("\($0.description)")
            }
            .foregroundStyle(Color.black)
            
            StepperPicker(
                value: $viewModel.maxLevel,
                options: LevelChartsViewModel.WaveNumber.allCases) {
                    Text("\($0.rawValue)")
            }
            .foregroundStyle(Color.black)
            
            chart
        }
    }
    
    private var chart: some View {
        VStack(alignment: .leading) {
            Text("Enemy Health")
                .font(.headline)
                .padding(.bottom, 8)
            
            BasicChart(
                data: viewModel.chartData,
                xLabel: "Wave",
                yLabel: "Health"
            )
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    LevelChartsView(viewModel: assembler.resolver.levelChartsViewModel())
}

