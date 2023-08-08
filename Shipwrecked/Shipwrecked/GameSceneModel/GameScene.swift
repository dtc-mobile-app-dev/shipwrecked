//
//  GameScene.swift
//  Shipwrecked
//
//  Created by Asher McConnell on 8/1/23.
//

import Foundation
import SpriteKit
import GameController
import GameplayKit
import SwiftUI


final class GameScene: SKScene, SKPhysicsContactDelegate, ObservableObject {
    
    @Published var currentHealth = 0
    @MainActor var joyconAngle = 0
    @Published var currentPlayer: Player?
    @Published var currentWeapon: Weapon?
    
    // MARK: Instances
    
    var animation = AnimationManager.instance
    var node = SpriteNodeManager.instance
    var tileMap = TileMapManager.instance
    
    // MARK: - PlayerNodes
    
    var currentPlayerNode = SKSpriteNode()
    
    var captainNode = SKSpriteNode()
    var captainPosx: CGFloat = 0
    var captainPosy: CGFloat = 0
    
    // MARK: - EnemyNodes
    
    var enemyNode = SKSpriteNode()
    //TEMP
    
    var enemyNode1 = SKSpriteNode()
    var enemyNode2 = SKSpriteNode()
    var enemyNode3 = SKSpriteNode()
    var enemyNode4 = SKSpriteNode()
    
    // MARK: - Combat
    
    let pi = Double.pi
    
    var bulletNode = SKSpriteNode()
    var swordNode = SKSpriteNode()
    
    var isShootin = false
    var isFiring = false
    var shootTimer = Timer()
    
    var isStrikin = false
    var isSwingin = false
    var swingTimer = Timer()
    
    var signNode = SKSpriteNode()
    
    let wSentientStick: Weapon = Weapon(name: "Sentient Stick", image: Image("SentientStickFront"), damage: 6, isGun: false)
    let wGun: Weapon = Weapon(name: "Musket", image: Image("CannonBall"), damage: 11, isGun: true)
    let wSword: Weapon = Weapon(name: "Sword", image: Image("Cutlass"), damage: 13, isGun: false)
    
    // MARK: - Camera/Controller
    
    var cam: SKCameraNode!
    var virtualController: GCVirtualController?
    
    // MARK: - PlayerAnimationBools
    
    var isAnimatingLeftPlayer = false
    var isAnimatingRightPlayer = false
    var isAnimatingUpPlayer = false
    var isAnimatingDownPlayer = false
    var isAnimatingUpRightDiagonalPlayer = false
    var isAnimatingUpLeftDiagonalPlayer = false
    var isAnimatingDownRightDiagonalPlayer = false
    var isAnimatingDownLeftDiagonalPlayer = false
    
    // MARK: - EnemyAnimationBools
    
    var isAnimatingLeftEnemy = false
    var isAnimatingRightEnemy = false
    var isAnimatingUpEnemy = false
    var isAnimatingDownEnemy = false
    var isAnimatingUpRightDiagonalEnemy = false
    var isAnimatingUpLeftDiagonalEnemy = false
    var isAnimatingDownRightDiagonalEnemy = false
    var isAnimatingDownLeftDiagonalEnemy = false
    
    // MARK: - PHYSICS CATEGORIES
    
    let wallCategory: UInt32 = 0x1
    let pathCategory: UInt32 = 0x10
    
    let playerCategory: UInt32 = 0x100
    let enemyCategory: UInt32 = 0x1000
    
    let bulletCategory: UInt32 = 0x2
    
    let signCategory: UInt32 = 0x10000
    
    let blank: UInt32 = 0x10000
    let blank2: UInt32 = 0x100000
    
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        // MARK: - TileMapNodes
        
        //                tileMap.createTileMapNode(tileMapSceneName: "Mountains", selfCategory: wallCategory, collisionCategory: playerCategory, scene: self)
        //        //
        //                tileMap.createTileMapNode(tileMapSceneName: "Water", selfCategory: wallCategory, collisionCategory: playerCategory, scene: self)
        //        //
        //                tileMap.createTileMapNode(tileMapSceneName: "Palms", selfCategory: wallCategory, collisionCategory: playerCategory, scene: self)
        
        //        tileMap.createTileMapNode(tileMapSceneName: "VolcanoWall", selfCategory: wallCategory, collisionCategory: playerCategory, scene: self)
        //        tileMap.createTileMapNode(tileMapSceneName: "VolcanoPath", selfCategory: pathCategory, collisionCategory: blank, scene: self)
        
        //
        tileMap.createTileMapNode(tileMapSceneName: "CaveWall", selfCategory: wallCategory, collisionCategory: playerCategory, scene: self)
        tileMap.createTileMapNode(tileMapSceneName: "CavePath", selfCategory: pathCategory, collisionCategory: blank, scene: self)
        
        // MARK: - SignNodes
        
        
        // MARK: - Characters
        
        createPlayer()
        
        //        createCaptain()
        
        // MARK: - Enemies
        
        
        
        
        // MARK: - Camera/Controller
        
        camera()
        connectVirtualController()
    }
    // MARK: - CHARACTERS
    
    func createPlayer() {
        
        currentPlayerNode = .init(imageNamed: currentPlayer?.character ?? "nil")
        
        currentPlayerNode.position = CGPoint(x: 100, y: 100)
        currentPlayerNode.zPosition = 9
        currentPlayerNode.setScale(0.5)
        currentPlayerNode.physicsBody = SKPhysicsBody(rectangleOf: currentPlayerNode.size)
        currentPlayerNode.physicsBody?.categoryBitMask = playerCategory
        currentPlayerNode.physicsBody?.collisionBitMask = wallCategory
        currentPlayerNode.physicsBody?.contactTestBitMask = wallCategory
        currentPlayerNode.physicsBody?.allowsRotation = false
        
        self.addChild(currentPlayerNode)
    }
    
    // MARK: - Enemies
    
    func createEnemy(withName: String, withNode: SKSpriteNode) {
        
        var nodeEnemy = withNode
        
        nodeEnemy = self.childNode(withName: withName) as! SKSpriteNode
        
        nodeEnemy.name = withName
        nodeEnemy.zPosition = 110
        nodeEnemy.setScale(0.5)
        nodeEnemy.physicsBody = SKPhysicsBody(rectangleOf: nodeEnemy.size)
        nodeEnemy.physicsBody?.categoryBitMask = enemyCategory
        nodeEnemy.physicsBody?.collisionBitMask = bulletCategory
        nodeEnemy.physicsBody?.contactTestBitMask = bulletCategory
        nodeEnemy.physicsBody?.allowsRotation = false
    }
    
    // MARK: - COMBAT
    
    @objc func gunFire() {
        bulletNode = .init(imageNamed: "Bullet")
        
        bulletNode.position = CGPoint(x: currentPlayerNode.position.x, y: currentPlayerNode.position.y )
        bulletNode.zPosition = 10
        bulletNode.setScale(0.1)
        bulletNode.zRotation = CGFloat(joyconAngle.degreesToRadians)
        bulletNode.physicsBody = SKPhysicsBody(rectangleOf: bulletNode.size)
        bulletNode.physicsBody?.affectedByGravity = false
        bulletNode.physicsBody?.categoryBitMask = bulletCategory
        bulletNode.physicsBody?.contactTestBitMask = enemyCategory
        bulletNode.physicsBody?.collisionBitMask = enemyCategory
        bulletNode.physicsBody?.isDynamic = false
        bulletNode.physicsBody?.usesPreciseCollisionDetection = true
//        bulletNode.anchorPoint = CGPoint(x:0.5,y: 0)
        
        
        let shoot = SKAction.move(to: CGPoint(
            x: 2000 * cos(bulletNode.zRotation) + bulletNode.position.x,
            y: 2000 * sin(bulletNode.zRotation) + bulletNode.position.y)
                                  ,duration: 3.0)
        let deleteBullet = SKAction.removeFromParent()
        
        let bulletSeq = SKAction.sequence([shoot, deleteBullet])
        if isShootin {
            self.addChild(bulletNode)
            bulletNode.run(bulletSeq)
        }
    }
    
    func startShooting() {
        shootTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(gunFire), userInfo: nil, repeats: true)
        isFiring = true
    }
    
    @objc func swing() {
        swordNode = .init(imageNamed: "Cutlass")
        
        swordNode.position = CGPoint(x: currentPlayerNode.position.x, y: currentPlayerNode.position.y - 10 )
        swordNode.setScale(0.4)
        swordNode.zPosition = 10
        swordNode.zRotation = CGFloat(joyconAngle.degreesToRadians)
        swordNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: swordNode.size.width / 3 , height: swordNode.size.height * 1.6))
        swordNode.physicsBody?.affectedByGravity = false
        swordNode.physicsBody?.categoryBitMask = bulletCategory
        swordNode.physicsBody?.contactTestBitMask = enemyCategory
        swordNode.physicsBody?.collisionBitMask = enemyCategory
        swordNode.physicsBody?.isDynamic = false
        swordNode.physicsBody?.usesPreciseCollisionDetection = true
        swordNode.anchorPoint = CGPoint(x:0,y: -0.2)
        
        var rotation = swordNode.zRotation
        rotation += pi / 4 * 8.3
        swordNode.zRotation = rotation
        
        
        let swing = SKAction.rotate(byAngle: -pi * 2 / 3, duration: 0.7)
        let deleteSword = SKAction.removeFromParent()
        
        let swingSeq = SKAction.sequence([swing, deleteSword])
        if isSwingin {
            self.addChild(swordNode)
            swordNode.run(swingSeq)
        }
    }
    
    func startSwinging() {
        swingTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(swing), userInfo: nil, repeats: true)
        isStrikin = true
    }
    
    func updateAngle(degrees: Int, isAttacking: Bool) {
        joyconAngle = degrees
        self.isShootin = isAttacking
        self.isSwingin = isAttacking
    }
    
    // MARK: - ENEMY CHASING
    
    func enemyMove(node: SKSpriteNode, enemyName: String) {
        let differenceX = node.position.x - currentPlayerNode.position.x
        let differenceY = node.position.y - currentPlayerNode.position.y
        let angle = atan2(differenceY, differenceX)
        let chaseSpeed: CGFloat = -3
        let vx = chaseSpeed * cos(angle)
        let vy = chaseSpeed * sin(angle)
        
        let pi = Double.pi
        
        var angle2 = angle + 7 * pi/8
        
        if angle2 < 0 {
            angle2 = angle2 + 2 * pi
        }
        
        if angle2 < pi/4 { // UPRIGHT
            if !isAnimatingUpRightDiagonalEnemy {
                animation.animate(character: enemyName, direction: .upRight, characterNode: node)
                setAnimateBoolsEnemy(direction: .upRight)
            }
        } else if angle2 < pi/2 { // UP
            if !isAnimatingUpEnemy {
                animation.animate(character: enemyName, direction: .up, characterNode: node)
                setAnimateBoolsEnemy(direction: .up)
            }
        } else if angle2 < 3 * pi/4 { // UPLEFT
            if !isAnimatingUpLeftDiagonalEnemy {
                animation.animate(character: enemyName, direction: .upLeft, characterNode: node)
                setAnimateBoolsEnemy(direction: .upLeft)
            }
        } else if angle2 < pi { // LEFT
            if !isAnimatingLeftEnemy {
                animation.animate(character: enemyName, direction: .left, characterNode: node)
                setAnimateBoolsEnemy(direction: .left)
            }
        } else if angle2 < 5 * pi/4 { // DOWNLEFT
            if !isAnimatingDownLeftDiagonalEnemy {
                animation.animate(character: enemyName, direction: .downLeft, characterNode: node)
                setAnimateBoolsEnemy(direction: .downLeft)
            }
        } else if angle2 < 3 * pi/2 { // DOWN
            if !isAnimatingDownEnemy {
                animation.animate(character: enemyName, direction: .down, characterNode: node)
                setAnimateBoolsEnemy(direction: .down)
            }
        } else if angle2 < 7 * pi/4 { // DOWNRIGHT
            if !isAnimatingDownRightDiagonalEnemy {
                animation.animate(character: enemyName, direction: .downRight, characterNode: node)
                setAnimateBoolsEnemy(direction: .downRight)
            }
        } else { // RIGHT
            if !isAnimatingRightEnemy {
                animation.animate(character: enemyName, direction: .right, characterNode: node)
                setAnimateBoolsEnemy(direction: .right)
            }
        }
        
        node.position.x += vx
        node.position.y += vy
    }
    
    // MARK: - CAMERA
    
    func camera() {
        
        cam = SKCameraNode()
        cam.zPosition = 10
        cam.position = CGPoint(x: 0, y: 0)
        cam.setScale(1.2)
        
        addChild(cam)
        camera = cam
    }
    
    // MARK: - PHYSICS INTERACTION
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node?.physicsBody?.categoryBitMask
        let bodyB = contact.bodyB.node?.physicsBody?.categoryBitMask
        
        print("ContactA = \(bodyA), ContactB = \(bodyB)")
        
        if bodyA == enemyCategory && bodyB == bulletCategory {
            contact.bodyA.node?.removeFromParent()
        }
    }
    
    // MARK: - CONTROLLER
    
    func connectVirtualController() {
        
        let controllerConfic = GCVirtualController.Configuration()
        controllerConfic.elements = [GCInputLeftThumbstick, GCInputButtonA]
        
        let controller = GCVirtualController(configuration: controllerConfic)
        controller.connect()
        virtualController = controller
    }
    
    // MARK: - UPDATES
    
    override func update(_ currentTime: TimeInterval) {
        // MARK: -Combat
        
//        if !isFiring {
//            startShooting()
//        }
        
                if !isStrikin {
                    startSwinging()
                }
        
        // MARK: - Created controller
        
        captainPosx = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value)!)
        captainPosy = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.yAxis.value)!)
        
        // MARK: - ButtonA
        
        let buttonA = (virtualController?.controller?.extendedGamepad?.buttonA.isTouched)!
        
        // MARK: - Joystick Movement
        
        if captainPosy <= -0.5 && captainPosx <= -0.5 { // GOING DOWN LEFT
            currentPlayerNode.position.y += -2.5
            currentPlayerNode.position.x += -2.5
            
            if !isAnimatingDownLeftDiagonalPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .downLeft, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .downLeft)
            }
        } else if captainPosy <= -0.5 && captainPosx >= 0.5 { // GOING DOWN RIGHT
            currentPlayerNode.position.y += -2.5
            currentPlayerNode.position.x += 2.5
            
            if !isAnimatingDownRightDiagonalPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .downRight, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .downRight)
            }
        } else if captainPosy >= 0.5 && captainPosx <= -0.5 { // GOING UP Left
            currentPlayerNode.position.y += 2.5
            currentPlayerNode.position.x += -2.5
            
            if !isAnimatingUpLeftDiagonalPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .upLeft, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .upLeft)
            }
        } else if captainPosy >= 0.5 && captainPosx >= 0.5 { // GOING UP RIGHT
            currentPlayerNode.position.y += 2.5
            currentPlayerNode.position.x += 2.5
            
            if !isAnimatingUpRightDiagonalPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .upRight, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .upRight)
            }
        } else if captainPosx >= 0.5 { // GOING RIGHT
            currentPlayerNode.position.x += 5
            if !isAnimatingRightPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .right, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .right)
            }
            
        } else if captainPosx <= -0.5 { // GOING LEFT
            currentPlayerNode.position.x -= 5
            if !isAnimatingLeftPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .left, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .left)
            }
        } else if captainPosy >= 0.5 { // GOING UP
            currentPlayerNode.position.y += 5
            
            if !isAnimatingUpPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .up, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .up)
            }
            
        } else if captainPosy <= -0.5 { // GOING DOWN
            
            currentPlayerNode.position.y -= 5
            
            if !isAnimatingDownPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .down, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .down)
            }
        } else {
            currentPlayerNode.removeAllActions()
            
            isAnimatingLeftPlayer = false
            isAnimatingRightPlayer = false
            isAnimatingUpPlayer = false
            isAnimatingDownPlayer = false
            isAnimatingUpRightDiagonalPlayer = false
            isAnimatingUpLeftDiagonalPlayer = false
            isAnimatingDownRightDiagonalPlayer = false
            isAnimatingDownLeftDiagonalPlayer = false
        }
        // MARK: - Cam with Player
        
        cam.position.x = currentPlayerNode.position.x
        cam.position.y = currentPlayerNode.position.y
        
        // MARK: - ENEMY CHASE
        
        print("\(joyconAngle)")
        
    }
    
    // MARK: - RESET ANIMATION PLAYER
    
    func setAnimateBoolsPlayer(direction: Direction) {
        
        switch direction {
        case .up:
            isAnimatingLeftPlayer = false
            isAnimatingRightPlayer = false
            isAnimatingUpPlayer = true
            isAnimatingDownPlayer = false
            isAnimatingUpRightDiagonalPlayer = false
            isAnimatingUpLeftDiagonalPlayer = false
            isAnimatingDownRightDiagonalPlayer = false
            isAnimatingDownLeftDiagonalPlayer = false
        case .down:
            isAnimatingLeftPlayer = false
            isAnimatingRightPlayer = false
            isAnimatingUpPlayer = false
            isAnimatingDownPlayer = true
            isAnimatingUpRightDiagonalPlayer = false
            isAnimatingUpLeftDiagonalPlayer = false
            isAnimatingDownRightDiagonalPlayer = false
            isAnimatingDownLeftDiagonalPlayer = false
        case .left:
            isAnimatingLeftPlayer = true
            isAnimatingRightPlayer = false
            isAnimatingUpPlayer = false
            isAnimatingDownPlayer = false
            isAnimatingUpRightDiagonalPlayer = false
            isAnimatingUpLeftDiagonalPlayer = false
            isAnimatingDownRightDiagonalPlayer = false
            isAnimatingDownLeftDiagonalPlayer = false
        case .right:
            isAnimatingLeftPlayer = false
            isAnimatingRightPlayer = true
            isAnimatingUpPlayer = false
            isAnimatingDownPlayer = false
            isAnimatingUpRightDiagonalPlayer = false
            isAnimatingUpLeftDiagonalPlayer = false
            isAnimatingDownRightDiagonalPlayer = false
            isAnimatingDownLeftDiagonalPlayer = false
        case .upRight:
            isAnimatingLeftPlayer = false
            isAnimatingRightPlayer = false
            isAnimatingUpPlayer = false
            isAnimatingDownPlayer = false
            isAnimatingUpRightDiagonalPlayer = true
            isAnimatingUpLeftDiagonalPlayer = false
            isAnimatingDownRightDiagonalPlayer = false
            isAnimatingDownLeftDiagonalPlayer = false
        case .upLeft:
            isAnimatingLeftPlayer = false
            isAnimatingRightPlayer = false
            isAnimatingUpPlayer = false
            isAnimatingDownPlayer = false
            isAnimatingUpRightDiagonalPlayer = false
            isAnimatingUpLeftDiagonalPlayer = true
            isAnimatingDownRightDiagonalPlayer = false
            isAnimatingDownLeftDiagonalPlayer = false
        case .downRight:
            isAnimatingLeftPlayer = false
            isAnimatingRightPlayer = false
            isAnimatingUpPlayer = false
            isAnimatingDownPlayer = false
            isAnimatingUpRightDiagonalPlayer = false
            isAnimatingUpLeftDiagonalPlayer = false
            isAnimatingDownRightDiagonalPlayer = true
            isAnimatingDownLeftDiagonalPlayer = false
        case .downLeft:
            isAnimatingLeftPlayer = false
            isAnimatingRightPlayer = false
            isAnimatingUpPlayer = false
            isAnimatingDownPlayer = false
            isAnimatingUpRightDiagonalPlayer = false
            isAnimatingUpLeftDiagonalPlayer = false
            isAnimatingDownRightDiagonalPlayer = false
            isAnimatingDownLeftDiagonalPlayer = true
        }
    }
    
    func setAnimateBoolsEnemy(direction: Direction) {
        
        switch direction {
        case .up:
            isAnimatingLeftEnemy = false
            isAnimatingRightEnemy = false
            isAnimatingUpEnemy = true
            isAnimatingDownEnemy = false
            isAnimatingUpRightDiagonalEnemy = false
            isAnimatingUpLeftDiagonalEnemy = false
            isAnimatingDownRightDiagonalEnemy = false
            isAnimatingDownLeftDiagonalEnemy = false
        case .down:
            isAnimatingLeftEnemy = false
            isAnimatingRightEnemy = false
            isAnimatingUpEnemy = false
            isAnimatingDownEnemy = true
            isAnimatingUpRightDiagonalEnemy = false
            isAnimatingUpLeftDiagonalEnemy = false
            isAnimatingDownRightDiagonalEnemy = false
            isAnimatingDownLeftDiagonalEnemy = false
        case .left:
            isAnimatingLeftEnemy = true
            isAnimatingRightEnemy = false
            isAnimatingUpEnemy = false
            isAnimatingDownEnemy = false
            isAnimatingUpRightDiagonalEnemy = false
            isAnimatingUpLeftDiagonalEnemy = false
            isAnimatingDownRightDiagonalEnemy = false
            isAnimatingDownLeftDiagonalEnemy = false
        case .right:
            isAnimatingLeftEnemy = false
            isAnimatingRightEnemy = true
            isAnimatingUpEnemy = false
            isAnimatingDownEnemy = false
            isAnimatingUpRightDiagonalEnemy = false
            isAnimatingUpLeftDiagonalEnemy = false
            isAnimatingDownRightDiagonalEnemy = false
            isAnimatingDownLeftDiagonalEnemy = false
        case .upRight:
            isAnimatingLeftEnemy = false
            isAnimatingRightEnemy = false
            isAnimatingUpEnemy = false
            isAnimatingDownEnemy = false
            isAnimatingUpRightDiagonalEnemy = true
            isAnimatingUpLeftDiagonalEnemy = false
            isAnimatingDownRightDiagonalEnemy = false
            isAnimatingDownLeftDiagonalEnemy = false
        case .upLeft:
            isAnimatingLeftEnemy = false
            isAnimatingRightEnemy = false
            isAnimatingUpEnemy = false
            isAnimatingDownEnemy = false
            isAnimatingUpRightDiagonalEnemy = false
            isAnimatingUpLeftDiagonalEnemy = true
            isAnimatingDownRightDiagonalEnemy = false
            isAnimatingDownLeftDiagonalEnemy = false
        case .downRight:
            isAnimatingLeftEnemy = false
            isAnimatingRightEnemy = false
            isAnimatingUpEnemy = false
            isAnimatingDownEnemy = false
            isAnimatingUpRightDiagonalEnemy = false
            isAnimatingUpLeftDiagonalEnemy = false
            isAnimatingDownRightDiagonalEnemy = true
            isAnimatingDownLeftDiagonalEnemy = false
        case .downLeft:
            isAnimatingLeftEnemy = false
            isAnimatingRightEnemy = false
            isAnimatingUpEnemy = false
            isAnimatingDownEnemy = false
            isAnimatingUpRightDiagonalEnemy = false
            isAnimatingUpLeftDiagonalEnemy = false
            isAnimatingDownRightDiagonalEnemy = false
            isAnimatingDownLeftDiagonalEnemy = true
        }
    }
}


extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / .pi }
}

