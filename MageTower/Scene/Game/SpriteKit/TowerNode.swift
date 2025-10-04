//Created by Alexander Skorulis on 4/10/2025.

import Foundation
import SpriteKit

final class TowerNode: SKShapeNode {
    
    convenience init(size: CGFloat) {
        self.init(circleOfRadius: size)
        
        fillColor = .white
        strokeColor = .clear
        position = .zero
        physicsBody = SKPhysicsBody(circleOfRadius: size)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = PhysicsCategory.circle
        physicsBody?.contactTestBitMask = PhysicsCategory.square
    }
}
