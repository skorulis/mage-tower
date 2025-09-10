//  Created by Alexander Skorulis on 10/9/2025.

import SwiftUI
import SpriteKit

struct ContentView: View {
    var body: some View {
        let scene = GameScene(size: UIScreen.main.bounds.size)
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
