//  Created by Alexander Skorulis on 10/9/2025.

import ASKCoordinator
import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @State var coordinator = Coordinator(root: GamePath.mainMenu)
    @Environment(\.resolver) private var resolver
    
    var body: some View {
        CoordinatorView(coordinator: coordinator)
            .with(renderer: resolver!.gamePathRenderer())
    }
}

#Preview {
    ContentView()
}
