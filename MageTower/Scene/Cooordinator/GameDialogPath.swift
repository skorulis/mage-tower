//Created by Alexander Skorulis on 12/10/2025.

import ASKCoordinator
import SwiftUI

enum GameDialogPath: CoordinatorPath {
 
    case inGameStatistics
    case mainStatDetails(stat: MainStat, inGame: Bool)
    
    public var id: String {
        String(describing: self)
    }
}

extension CustomOverlay.Name {
    static let dialog = CustomOverlay.Name("dialog")
}

struct GameDialogPathRenderer: CoordinatorPathRenderer {
    
    let resolver: MageTowerResolver
    
    @ViewBuilder
    func render(path: GameDialogPath, in coordinator: Coordinator) -> some View {
        switch path {
        case .inGameStatistics:
            InGameStatsView(stats: resolver.gameStore().statistics)
        case let .mainStatDetails(stat, inGame):
            MainStatDetailsDialog(
                viewModel: resolver.mainStatDetailsDialogViewModel(stat: stat, inGame: inGame)
            )
        }
    }
}


private extension Coordinator {
    func apply<Obj>(_ obj: Obj) -> Obj {
        (obj as? CoordinatorViewModel)?.coordinator = self
        return obj
    }
}

