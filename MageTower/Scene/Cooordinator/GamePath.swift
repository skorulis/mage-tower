//  Created by Alexander Skorulis on 12/9/2025.

import ASKCoordinator
import Knit
import SwiftUI

public enum GamePath: CoordinatorPath {
 
    case menuTabs
    case mainMenu
    case game
    case levelCharts
    case statCharts
    case workshop
    
    public var id: String {
        String(describing: self)
    }
}


public struct GamePathRenderer: CoordinatorPathRenderer {
    
    let resolver: MageTowerResolver
    
    @ViewBuilder
    public func render(path: GamePath, in coordinator: Coordinator) -> some View {
        switch path {
        case .menuTabs:
            MenuTabView(viewModel: coordinator.apply(resolver.menuTabViewModel()))
        case .mainMenu:
            MainMenuView(viewModel: resolver.mainMenuViewModel(coordinator: coordinator))
        case .game:
            GameView(viewModel: coordinator.apply(resolver.gameViewModel()))
        case .levelCharts:
            LevelChartsView(viewModel: coordinator.apply(resolver.levelChartsViewModel()))
        case .statCharts:
            StatChartView(viewModel: coordinator.apply(resolver.statChartViewModel()))
        case .workshop:
            WorkShopView(viewModel: coordinator.apply(resolver.workShopViewModel()))
        }
    }
}


private extension Coordinator {
    func apply<Obj>(_ obj: Obj) -> Obj {
        (obj as? CoordinatorViewModel)?.coordinator = self
        return obj
    }
}
