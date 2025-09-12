//  Created by Alexander Skorulis on 10/9/2025.

import Foundation
import Knit
import SwiftUI

final class MageTowerAssembly: AutoInitModuleAssembly {
    typealias TargetResolver = MageTowerResolver
    
    init() {}
    
    @MainActor func assemble(container: Container<TargetResolver>) {
        container.register(GameService.self) { _ in
            GameService()
        }
        
        container.register(EnemyService.self) { _ in
            EnemyService()
        }
    }
    
    static var dependencies: [any Knit.ModuleAssembly.Type] { [] }
}

nonisolated final class MageTowerResolver: BaseResolver {}

extension EnvironmentValues {
    @Entry var resolver: MageTowerResolver?
}
