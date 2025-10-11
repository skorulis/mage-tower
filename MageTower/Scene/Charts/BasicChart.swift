//Created by Alexander Skorulis on 11/10/2025.

import Charts
import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct BasicChart {
    let data: [ChartDataPoint]
    let xLabel: String
    let yLabel: String
    
    struct ChartDataPoint {
        let x: Int
        let y: Double
    }
}

// MARK: - Rendering

extension BasicChart: View {
    
    var body: some View {
        Chart(data, id: \.x) { dataPoint in
            LineMark(
                x: .value(xLabel, dataPoint.x),
                y: .value(yLabel, dataPoint.y)
            )
            .foregroundStyle(.blue)
            .lineStyle(StrokeStyle(lineWidth: 2))
            
            PointMark(
                x: .value(xLabel, dataPoint.x),
                y: .value(yLabel, dataPoint.y)
            )
            .foregroundStyle(.blue)
            .symbolSize(20)
        }
        .chartXScale(domain: 1...(data.last?.x ?? 100))
        .frame(height: 300)
    }
}

