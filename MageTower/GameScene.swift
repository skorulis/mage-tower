//  GameScene.swift
//  MageTower
//
//  Created by Alexander Skorulis on 10/9/2025.
//

import SpriteKit

class GameScene: SKScene {
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

        let circleNode = SKShapeNode(circleOfRadius: 50)
        circleNode.fillColor = .white
        circleNode.strokeColor = .clear
        circleNode.position = CGPoint(x: frame.midX, y: frame.midY)
        circleNode.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        circleNode.physicsBody?.isDynamic = false
        addChild(circleNode)
        self.circleNode = circleNode

        let spawnRadius: CGFloat = 100

        let squareSize: CGFloat = 20
        let squareNode = SKShapeNode(rectOf: CGSize(width: squareSize, height: squareSize))
        squareNode.fillColor = .white
        squareNode.strokeColor = .clear
        squareNode.position = CGPoint(x: frame.midX, y: frame.midX - spawnRadius)
        squareNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: squareSize, height: squareSize))
        squareNode.physicsBody?.allowsRotation = false
        squareNode.physicsBody?.linearDamping = 2.0
        squareNode.physicsBody?.restitution = 0.0
        addChild(squareNode)
        self.squareNode = squareNode
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
}


