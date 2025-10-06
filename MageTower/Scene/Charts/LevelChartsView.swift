//Created by Alexander Skorulis on 4/10/2025.

import ASKCoordinator
import Charts
import Foundation
import Knit
import SwiftUI

// MARK: - Memory footprint

struct ChartDataPoint {
    let wave: Int
    let health: Double
}

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
            title: "Charts",
            backAction: { viewModel.coordinator?.pop() }
        )
    }
    
    private var content: some View {
        VStack {
            chart
        }
    }
    
    private var chart: some View {
        VStack(alignment: .leading) {
            Text("Enemy Health")
                .font(.headline)
                .padding(.bottom, 8)
            
            Chart(viewModel.chartData, id: \.wave) { dataPoint in
                LineMark(
                    x: .value("Wave", dataPoint.wave),
                    y: .value("Health", dataPoint.health)
                )
                .foregroundStyle(.blue)
                .lineStyle(StrokeStyle(lineWidth: 2))
                
                PointMark(
                    x: .value("Wave", dataPoint.wave),
                    y: .value("Health", dataPoint.health)
                )
                .foregroundStyle(.blue)
                .symbolSize(20)
            }
            .chartXScale(domain: 1...20)
            .chartYScale(domain: 0...maxHealth)
            .chartXAxis {
                AxisMarks(values: .stride(by: 2)) { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel()
                }
            }
            .chartYAxis {
                AxisMarks(values: .stride(by: 5)) { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel()
                }
            }
            .frame(height: 300)
            .padding()
        }
    }
    
    private var maxHealth: Double {
        viewModel.chartData.map(\.health).max() ?? 50
    }
}

// MARK: - Previews

#Preview {
    let assembler = MageTowerAssembly.testing()
    LevelChartsView(viewModel: assembler.resolver.levelChartsViewModel())
}

