//Created by Alexander Skorulis on 11/10/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct DialogView<Content: View> {
    
    @Binding var isVisible: Bool
    let content: () -> Content
    
}

// MARK: - Rendering

extension DialogView: View {
    
    var body: some View {
        ZStack {
            if isVisible {
                // Dimmed background
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isVisible = false
                    }
                    .transition(.opacity)
                
                // Dialog content
                DialogBox {
                    content()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
                .onTapGesture {
                    // Prevent tap from propagating to background
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.15), value: isVisible)
    }
}

extension View {
    
    func dialog<Content: View>(isVisible: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        overlay(
            DialogView(isVisible: isVisible, content: content)
        )
    }
}

// MARK: - Previews

#Preview {
    @Previewable @State var dialogVisible: Bool = false
    
    ZStack {
        Color.white
        Button("Show") {
            dialogVisible = true
        }
    }
    .overlay(
        DialogView(isVisible: $dialogVisible) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Sample Dialog")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("This is a dialog with a dimmed background. Tap outside to dismiss.")
                    .font(.body)
                
                HStack(spacing: 12) {
                    Button("Cancel") {
                        print("Cancel tapped")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.gray)
                    .cornerRadius(8)
                    
                    Button("Confirm") {
                        print("Confirm tapped")
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(8)
                }
            }
        }
    )
}
