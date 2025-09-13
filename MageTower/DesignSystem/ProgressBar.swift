//  Created by Alexander Skorulis on 13/9/2025.

import SwiftUI

public struct ProgressBar {
    let value: CGFloat
    let color: Color
    
    public init(
        value: CGFloat,
        color: Color
    ) {
        self.value = value
        self.color = color
    }
}

extension ProgressBar: View {
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background bar
                Rectangle()
                    .fill(color.opacity(0.3))
                
                // Foreground progress bar
                Rectangle()
                    .fill(color)
                    .frame(width: geometry.size.width * value)
            }
        }
        .frame(height: 8)
        .cornerRadius(8)
    }
}

#Preview {
    VStack(spacing: 8) {
        ProgressBar(value: 0.5, color: .red)
        ProgressBar(value: 0.75, color: .red)
    }
    .padding()
}
