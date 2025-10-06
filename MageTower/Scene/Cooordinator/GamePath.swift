//  Created by Alexander Skorulis on 12/9/2025.

import ASKCoordinator
import Knit
import SwiftUI

public enum GamePath: CoordinatorPath {
 
    case mainMenu
    case game
    case levelCharts
    
    public var id: String {
        String(describing: self)
    }
}


public struct GamePathRenderer: CoordinatorPathRenderer {
    
    let resolver: MageTowerResolver
    
    @ViewBuilder
    public func render(path: GamePath, in coordinator: Coordinator) -> some View {
        switch path {
        case .mainMenu:
            MainMenuView(viewModel: coordinator.apply(resolver.mainMenuViewModel()))
        case .game:
            GameView(viewModel: coordinator.apply(resolver.gameViewModel()))
        case .levelCharts:
            LevelChartsView(viewModel: coordinator.apply(resolver.levelChartsViewModel()))
        }
    }
}


private extension Coordinator {
    func apply<Obj>(_ obj: Obj) -> Obj {
        (obj as? CoordinatorViewModel)?.coordinator = self
        return obj
    }
}
