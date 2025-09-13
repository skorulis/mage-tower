//  Created by Alexander Skorulis on 10/9/2025.

import Foundation
import Knit
import SwiftUI

final class MageTowerAssembly: AutoInitModuleAssembly {
    typealias TargetResolver = MageTowerResolver
    
    init() {}
    
    @MainActor func assemble(container: Container<TargetResolver>) {        
        container.register(EnemyService.self) { _ in
            EnemyService()
        }
        
        container.register(GameService.self) { _ in GameService() }
        
        container.register(SpawnService.self) { _ in SpawnService() }
        
        container.register(GamePathRenderer.self) { GamePathRenderer(resolver: $0) }
        
        registerViewModels(container: container)
    }
    
    private func registerViewModels(container: Container<TargetResolver>) {
        container.register(GameViewModel.self) { GameViewModel.make(resolver: $0) }
    }
    
    static var dependencies: [any Knit.ModuleAssembly.Type] { [] }
}

// MARK: - Resolver setup

nonisolated final class MageTowerResolver: BaseResolver {}

extension MageTowerAssembly {
    @MainActor static func testing() -> ScopedModuleAssembler<MageTowerResolver> {
        ScopedModuleAssembler<MageTowerResolver>([MageTowerAssembly()])
    }
}

extension EnvironmentValues {
    @Entry var resolver: MageTowerResolver?
}
