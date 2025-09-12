//  GameScene.swift
//  MageTower
//
//  Created by Alexander Skorulis on 10/9/2025.
//

import SpriteKit

private struct PhysicsCategory {
    static let circle: UInt32 = 0x1 << 0
    static let square: UInt32 = 0x1 << 1
    static let bullet: UInt32 = 0x1 << 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private let spawnService = SpawnService()
    private let enemyService = EnemyService()
    
    private var tower: SKShapeNode = SKShapeNode(circleOfRadius: 32)
    
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
        
        // Center the scene's coordinate system so (0,0) is at the middle of the view
        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        tower.fillColor = .white
        tower.strokeColor = .clear
        tower.position = .zero
        tower.physicsBody = SKPhysicsBody(circleOfRadius: 32)
        tower.physicsBody?.isDynamic = false
        tower.physicsBody?.categoryBitMask = PhysicsCategory.circle
        tower.physicsBody?.contactTestBitMask = PhysicsCategory.square
        addChild(tower)

        // Fire a bullet every 1 second toward a random square
        let fireAction = SKAction.sequence([
            SKAction.wait(forDuration: 0.5),
            SKAction.run { [weak self] in
                self?.fireBullet()
            }
        ])
        run(SKAction.repeatForever(fireAction), withKey: "fireTimer")
        
        let enemyAction = SKAction.sequence([
            SKAction.wait(forDuration: 1.0),
            SKAction.run { [weak self] in
                self?.addEnemy()
            }
        ])
        run(SKAction.repeatForever(enemyAction), withKey: "enemyTimer")
    }

    override func update(_ currentTime: TimeInterval) {
        for enemy in enemyService.enemies.values {
            guard let square = enemy.node, let body = square.physicsBody else {
                continue
            }
            let toCircle = CGVector(dx: tower.position.x - square.position.x,
                                    dy: tower.position.y - square.position.y)
            let distance = max(1.0, sqrt(toCircle.dx * toCircle.dx + toCircle.dy * toCircle.dy))
            let normalized = CGVector(dx: toCircle.dx / distance, dy: toCircle.dy / distance)
            let forceMagnitude: CGFloat = 5.0
            let force = CGVector(dx: normalized.dx * forceMagnitude, dy: normalized.dy * forceMagnitude)
            body.applyForce(force)
        }
    }
    
    func addEnemy() {
        var enemy = spawnService.spawn()
        
        let squareSize: CGFloat = 20
        let squareNode = SKShapeNode(rectOf: CGSize(width: squareSize, height: squareSize))
        squareNode.fillColor = .white
        squareNode.strokeColor = .clear
        squareNode.position = enemy.spawnPosition
        squareNode.userData = ["id": enemy.id]
        squareNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: squareSize, height: squareSize))
        squareNode.physicsBody?.allowsRotation = false
        squareNode.physicsBody?.linearDamping = 2.0
        squareNode.physicsBody?.restitution = 0.0
        squareNode.physicsBody?.categoryBitMask = PhysicsCategory.square
        squareNode.physicsBody?.contactTestBitMask = PhysicsCategory.circle | PhysicsCategory.bullet
        addChild(squareNode)
        
        enemy.node = squareNode
        self.enemyService.add(enemy: enemy)
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let categories = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if categories == (PhysicsCategory.circle | PhysicsCategory.square) {
            let squareBody = contact.bodyA.categoryBitMask == PhysicsCategory.square ? contact.bodyA : contact.bodyB
            let hitNode = squareBody.node as? SKShapeNode
            guard let uuid = squareBody.node?.userData?["id"] as? UUID else {
                return
            }
            print("Square hit circle: id=\(uuid)")
            
            enemyService.enemies.removeValue(forKey: uuid)
            hitNode?.removeFromParent()
            
        } else if categories == (PhysicsCategory.bullet | PhysicsCategory.square) {
            let squareBody = contact.bodyA.categoryBitMask == PhysicsCategory.square ? contact.bodyA : contact.bodyB
            let bulletBody = contact.bodyA.categoryBitMask == PhysicsCategory.bullet ? contact.bodyA : contact.bodyB
            guard let uuid = squareBody.node?.userData?["id"] as? UUID else {
                return
            }
            bulletBody.node?.removeFromParent()
            if enemyService.hit(uuid: uuid) {
                print("Enemy dead")
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("Did End")
    }

    private func fireBullet() {
        guard !enemyService.enemies.isEmpty else { return }
        guard let target = enemyService.closest()?.node else { return }

        let start = tower.position
        let targetPos = target.position
        let dx = targetPos.x - start.x
        let dy = targetPos.y - start.y
        let distance = max(1.0, sqrt(dx * dx + dy * dy))
        let dir = CGVector(dx: dx / distance, dy: dy / distance)

        let bulletRadius: CGFloat = 4
        let bullet = SKShapeNode(circleOfRadius: bulletRadius)
        bullet.fillColor = .cyan
        bullet.strokeColor = .clear
        bullet.position = start
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: bulletRadius)
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.allowsRotation = false
        bullet.physicsBody?.categoryBitMask = PhysicsCategory.bullet
        bullet.physicsBody?.contactTestBitMask = PhysicsCategory.square
        bullet.physicsBody?.collisionBitMask = 0
        bullet.physicsBody?.usesPreciseCollisionDetection = true
        addChild(bullet)

        let speed: CGFloat = 300 // points per second
        let travelDistance: CGFloat = 2000 // ensure it goes off-screen
        let endPoint = CGPoint(
            x: start.x + dir.dx * travelDistance,
            y: start.y + dir.dy * travelDistance
        )
        let duration = TimeInterval(travelDistance / speed)
        bullet.run(SKAction.sequence([
            SKAction.move(to: endPoint, duration: duration),
            SKAction.removeFromParent()
        ]))
    }
}


