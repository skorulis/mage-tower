//  Created by Alexander Skorulis on 13/9/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct InfoBox<Content: View> {
    
    let content: () -> Content
}

// MARK: - Rendering

extension InfoBox: View {
    
    var body: some View {
        content()
            .foregroundStyle(Color.white)
            .padding(4)
            .background(Color.boxBackground)
            .border(Color.white)
    }
}

// MARK: - Previews

#Preview {
    VStack {
        InfoBox {
            Text("Box Content")
        }
    }
    .padding(16)
    .background(Color.black)
    
}

