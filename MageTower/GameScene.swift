//  GameScene.swift
//  MageTower
//
//  Created by Alexander Skorulis on 10/9/2025.
//

import SpriteKit

private struct PhysicsCategory {
    static let circle: UInt32 = 0x1 << 0
    static let square: UInt32 = 0x1 << 1
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private let spawnService = SpawnService()
    
    private var circleNode: SKShapeNode?
    private var squareNode: SKShapeNode?
    override init(size: CGSize) {
        super.init(size: size)
        scaleMode = .resizeFill
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        scaleMode = .resizeFill
    }

    override func didMove(to view: SKView) {
        backgroundColor = .black
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        spawnService.towerPosition = CGPoint(x: frame.midX, y: frame.midY)

        let circleNode = SKShapeNode(circleOfRadius: 50)
        circleNode.fillColor = .white
        circleNode.strokeColor = .clear
        circleNode.position = CGPoint(x: frame.midX, y: frame.midY)
        circleNode.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        circleNode.physicsBody?.isDynamic = false
        circleNode.physicsBody?.categoryBitMask = PhysicsCategory.circle
        circleNode.physicsBody?.contactTestBitMask = PhysicsCategory.square
        addChild(circleNode)
        self.circleNode = circleNode
        
        addEnemy()

    }

    override func update(_ currentTime: TimeInterval) {
        guard let circle = circleNode, let square = squareNode, let body = square.physicsBody else { return }
        let toCircle = CGVector(dx: circle.position.x - square.position.x,
                                dy: circle.position.y - square.position.y)
        let distance = max(1.0, sqrt(toCircle.dx * toCircle.dx + toCircle.dy * toCircle.dy))
        let normalized = CGVector(dx: toCircle.dx / distance, dy: toCircle.dy / distance)
        let forceMagnitude: CGFloat = 50.0
        let force = CGVector(dx: normalized.dx * forceMagnitude, dy: normalized.dy * forceMagnitude)
        body.applyForce(force)
    }
    
    func addEnemy() {
        let enemy = spawnService.spawn()
        
        let squareSize: CGFloat = 20
        let squareNode = SKShapeNode(rectOf: CGSize(width: squareSize, height: squareSize))
        squareNode.fillColor = .white
        squareNode.strokeColor = .clear
        squareNode.position = enemy.spawnPosition
        squareNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: squareSize, height: squareSize))
        squareNode.physicsBody?.allowsRotation = false
        squareNode.physicsBody?.linearDamping = 2.0
        squareNode.physicsBody?.restitution = 0.0
        squareNode.physicsBody?.categoryBitMask = PhysicsCategory.square
        squareNode.physicsBody?.contactTestBitMask = PhysicsCategory.circle
        addChild(squareNode)
        self.squareNode = squareNode
        
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let categories = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if categories == (PhysicsCategory.circle | PhysicsCategory.square) {
            print("Square hit circle")
            self.squareNode?.removeFromParent()
            self.squareNode = nil
            
            addEnemy()
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("Did End")
    }
}


