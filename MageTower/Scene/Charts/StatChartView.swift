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
            title: "Charts",
            backAction: { viewModel.coordinator?.pop() }
        )
    }
    
    private var content: some View {
        VStack(spacing: 16) {
            StepperPicker(
                value: $viewModel.maxLevel,
                options: StatChartViewModel.StatLevel.allCases) {
                    Text("\($0.rawValue)")
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
            
            Chart(viewModel.chartCostData, id: \.wave) { dataPoint in
                LineMark(
                    x: .value("Level", dataPoint.wave),
                    y: .value("Cost", dataPoint.health)
                )
                .foregroundStyle(.blue)
                .lineStyle(StrokeStyle(lineWidth: 2))
                
                PointMark(
                    x: .value("Level", dataPoint.wave),
                    y: .value("Cost", dataPoint.health)
                )
                .foregroundStyle(.blue)
                .symbolSize(20)
            }
            .frame(height: 300)
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    StatChartView(viewModel: assembler.resolver.statChartViewModel())
}

