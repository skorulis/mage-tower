//Created by Alexander Skorulis on 11/10/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct DialogBox<Content: View> {
    
    let content: () -> Content
}

// MARK: - Rendering

extension DialogBox: View {
    
    var body: some View {
        ViewThatFits(in: .vertical) {
            paddedContent
            scrollingContent
        }
        .foregroundStyle(Color.white)
        .background(Color.boxBackground)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white, lineWidth: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var paddedContent: some View {
        content()
            .padding(16)
    }
    
    private var scrollingContent: some View {
        ScrollView {
            paddedContent
        }
    }
}

// MARK: - Previews

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        DialogBox {
            VStack(alignment: .leading, spacing: 12) {
                Text("Dialog Title")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("This is a sample dialog box with some content. It should fit the content and only scroll if there isn't enough space.")
                    .font(.body)
                
                Text("Additional content line 1")
                Text("Additional content line 2")
                Text("Additional content line 3")
                
                Button("Action Button") {
                    // Action
                }
                .foregroundColor(.black)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(8)
            }
        }
        .padding(20)
    }
}

#Preview("Long Content") {
    ZStack {
        Color.black.ignoresSafeArea()
        
        DialogBox {
            VStack(alignment: .leading, spacing: 12) {
                Text("Long Content Dialog")
                    .font(.title2)
                    .fontWeight(.bold)
                
                ForEach(0..<20, id: \.self) { index in
                    Text("This is line \(index + 1) of a very long dialog that should scroll when there isn't enough space.")
                        .font(.body)
                }
                
                Button("Bottom Action") {
                    // Action
                }
                .foregroundColor(.black)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(8)
            }
        }
        .padding(20)
    }
}
