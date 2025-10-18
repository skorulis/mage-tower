//Created by Alexander Skorulis on 18/10/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor struct MenuTabView {
    @Environment(\.resolver) private var resolver
    
    @State var viewModel: MenuTabViewModel
}

// MARK: - Rendering

extension MenuTabView: View {
    
    var body: some View {
        if let resolver {
            TabView {
                MainMenuView(viewModel: resolver.mainMenuViewModel(coordinator: viewModel.coordinator))
                    .tabItem {
                        Text("Main")
                    }
                
                WorkShopView(viewModel: resolver.workShopViewModel(coordinator: viewModel.coordinator))
                    .tabItem {
                        Text("Workshop")
                    }
            }
        }
    }
}
