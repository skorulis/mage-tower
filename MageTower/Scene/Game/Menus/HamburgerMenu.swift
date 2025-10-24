//Created by Alexander Skorulis on 25/10/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct HamburgerMenu {
    @State private var isOpen: Bool = false
    let onAction: (Action) -> Void
}

// MARK: - Inner Types

extension HamburgerMenu {
    enum Action {
        case endRound
    }
}

// MARK: - Rendering

extension HamburgerMenu: View {
    
    var body: some View {
        VStack(spacing: 4) {
            Button(action: { isOpen.toggle() }) {
                InfoBox {
                    Image(systemName: "line.3.horizontal")
                }
            }
            if isOpen {
                additionalButtons
            }
        }
    }
    
    private var additionalButtons: some View {
        VStack(spacing: 4) {
            Button(action: { onAction(.endRound) }) {
                InfoBox {
                    Image(systemName: "xmark.circle")
                }
            }
        }
        
    }
}

// MARK: - Previews

#Preview {
    ZStack(alignment: .topTrailing) {
        Color.black
            .ignoresSafeArea()
        HamburgerMenu(onAction: { _ in })
            .padding(.top, 12)
            .padding(.trailing, 16)
    }
    
}

