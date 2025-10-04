//Created by Alexander Skorulis on 3/10/2025.

import Foundation
import KnitMacros

final class WeaponService {
    
    private let gameStore: GameStore
    
    var fireTime: TimeInterval = 0
    var bullets: [UUID: Bullet] = [:]
    
    @Resolvable<MageTowerResolver>
    init(
        gameStore: GameStore,
    ) {
        self.gameStore = gameStore
    }
}

extension WeaponService {
    func addBullet() -> Bullet {
        let bullet = Bullet()
        bullets[bullet.id] = bullet
        return bullet
    }
}
