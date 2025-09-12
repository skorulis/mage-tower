//  Created by Alexander Skorulis on 12/9/2025.

import Knit
import KnitMacros
import SwiftUI

@Observable final class GameViewModel {
    
    let scene: GameScene
    
    @Resolvable<Resolver>
    init() {
        scene = GameScene(size: UIScreen.main.bounds.size)
    }
}
