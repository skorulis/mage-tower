//Created by Alexander Skorulis on 3/10/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct StepperPicker<EnumType: Equatable, Body: View> {
    @Binding var value: EnumType
    let options: [EnumType]
    let content: (EnumType) -> Body
    
    init(
        value: Binding<EnumType>,
        options: [EnumType],
        content: @escaping (EnumType) -> Body
    ) {
        _value = value
        self.options = options
        self.content = content
    }
}

// MARK: - Rendering

extension StepperPicker: View {
    
    var body: some View {
        HStack(spacing: 4) {
            previous
            content(value)
            next
        }
    }
    
    private var previous: some View {
        Button(action: previousAction) {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
        }
        
    }
    
    private var next: some View {
        Button(action: nextAction) {
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
        }
    }
    
    private var index: Int {
        return options.firstIndex(of: value) ?? 0
    }
    
    private func nextAction() {
        guard index < options.count - 1 else { return }
        value = options[index + 1]
    }
    
    private func previousAction() {
        guard index > 0 else { return }
        value = options[index - 1]
    }
}

// MARK: - Previews

#Preview {
    @Previewable @State var level: Level = .one
    
    StepperPicker(
        value: $level,
        options: Level.allCases) {
            Text("\($0.description)")
    }
    .foregroundStyle(Color.black)
}

