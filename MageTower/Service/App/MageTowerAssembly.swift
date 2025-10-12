//  Created by Alexander Skorulis on 10/9/2025.

import ASKCore
import Foundation
import Knit
import SwiftUI

final class MageTowerAssembly: AutoInitModuleAssembly {
    typealias TargetResolver = MageTowerResolver
    
    init() {}
    
    @MainActor func assemble(container: Container<TargetResolver>) {        
        container.register(EnemyService.self) { EnemyService.make(resolver: $0) }
        container.register(SpawnService.self) { _ in SpawnService() }
        container.register(WeaponService.self) { WeaponService.make(resolver: $0) }
        container.register(GamePathRenderer.self) { GamePathRenderer(resolver: $0) }
        container.register(GameDialogPathRenderer.self) { GameDialogPathRenderer(resolver: $0) }
        
        registerViewModels(container: container)
        registerStores(container: container)
    }
    
    private func registerStores(container: Container<TargetResolver>) {
        // @knit ignore
        container.register(PKeyValueStore.self) { _ in
            UserDefaults.standard
        }
        
        container.register(GameStore.self) { _ in GameStore() }
            .inObjectScope(.container)
        
        container.register(PersistentStore.self) { PersistentStore.make(resolver: $0) }
            .inObjectScope(.container)
    }
    
    private func registerViewModels(container: Container<TargetResolver>) {
        container.register(GameViewModel.self) { GameViewModel.make(resolver: $0) }
        container.register(InGameUpgradeViewModel.self) { InGameUpgradeViewModel.make(resolver: $0) }
        container.register(MainMenuViewModel.self) { MainMenuViewModel.make(resolver: $0) }
        container.register(LevelChartsViewModel.self) { LevelChartsViewModel.make(resolver: $0) }
        container.register(StatChartViewModel.self) { StatChartViewModel.make(resolver: $0) }
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
