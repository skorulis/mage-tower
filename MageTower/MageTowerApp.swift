//  Created by Alexander Skorulis on 10/9/2025.

import Knit
import SwiftUI

@main
struct MageTowerApp: App {
    
    private let assembler: ScopedModuleAssembler<MageTowerResolver> = {
        .init([MageTowerAssembly()])
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.resolver, assembler.resolver)
        }
    }
}
