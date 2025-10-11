//Created by Alexander Skorulis on 9/10/2025.

import Charts
import Foundation
import Knit
import SwiftUI
import ASKCoordinator

// MARK: - Memory footprint

@MainActor struct StatChartView {
    @State var viewModel: StatChartViewModel
}

// MARK: - Rendering

extension StatChartView: View {
    
    var body: some View {
        PageLayout {
            titleBar
        } content: {
            content
        }
    }
    
    private var titleBar: some View {
        TitleBar(
            title: "Stat Charts",
            backAction: { viewModel.coordinator?.pop() }
        )
    }
    
    private var content: some View {
        VStack(spacing: 16) {
            StepperPicker(
                value: $viewModel.maxLevel,
                options: viewModel.levelOptions) {
                    Text("\($0)")
            }
            .foregroundStyle(Color.black)
            
            chart
        }
        .padding(16)
    }
    
    private var chart: some View {
        VStack(alignment: .leading) {
            Text("Cost")
                .font(.headline)
                .padding(.bottom, 8)
            
            BasicChart(
                data: viewModel.chartCostData,
                xLabel: "Level",
                yLabel: "Cost"
            )
            
            Text(viewModel.stat.name)
                .font(.headline)
                .padding(.bottom, 8)
            
            BasicChart(
                data: viewModel.chartValueData,
                xLabel: "Level",
                yLabel: viewModel.stat.name,
            )
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    StatChartView(viewModel: assembler.resolver.statChartViewModel())
}

