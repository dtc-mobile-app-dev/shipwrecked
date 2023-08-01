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


final class GameScene: SKScene, SKPhysicsContactDelegate, ObservableObject {
    
    @Published var currentHealth = 0
    
    var animation = AnimationManager.instance
    var node = SpriteNodeManager.instance
    var tileMap = TileMapManager.instance
    
    var captainNode = SKSpriteNode()
    var enemyNode = SKSpriteNode()
    var signNode = SKSpriteNode()
    
    var captainPosx: CGFloat = 0
    var captainPosy: CGFloat = 0
    
    var isRunning = false
    var isAnimatingLeft = false
    var isAnimatingRight = false
    var isAnimatingUp = false
    var isAnimatingDown = false
    var isAnimatingUpRightDiagonal = false
    var isAnimatingUpLeftDiagonal = false
    var isAnimatingDownRightDiagonal = false
    var isAnimatingDownLeftDiagonal = false
    
    var cam: SKCameraNode!
    var virtualController: GCVirtualController?
    
    let wallCategory: UInt32 = 0x1
    let playerCategory: UInt32 = 0x10
    let signCategory: UInt32 = 0x100
    let enemyCategory: UInt32 = 0x1000
    
    let blank: UInt32 = 0x10000
    let blank2: UInt32 = 0x100000
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        // MARK: - TileMapNodes
        
        tileMap.createTileMapNode(tileMapSceneName: "Wall", selfCategory: wallCategory, collisionCategory: playerCategory, scene: self)
        
        tileMap.createTileMapNode(tileMapSceneName: "Wall2", selfCategory: wallCategory, collisionCategory: playerCategory, scene: self)
        
        // MARK: - SignNodes
        
        node.createSpriteNode(spriteNode: signNode, sceneNodeName: "Sign", selfCategory: signCategory, collisionContactCategory: playerCategory, scene: self)
        
        // MARK: - Characters
        
        createCaptain()
        
        // MARK: - Enemies
        
        createEnemy()

        
        camera()
        connectVirtualController()
    }
    
// MARK: - CHARACTERS
    
    // MARK: - CAPTAIN
    
    func createCaptain() {
        captainNode = self.childNode(withName: "Captain") as! SKSpriteNode

        captainNode.zPosition = 10
        captainNode.setScale(0.5)
        captainNode.physicsBody = SKPhysicsBody(rectangleOf: captainNode.size)
        captainNode.physicsBody?.categoryBitMask = playerCategory
        captainNode.physicsBody?.collisionBitMask = wallCategory
        captainNode.physicsBody?.contactTestBitMask = wallCategory
        captainNode.physicsBody?.allowsRotation = false
    }
    
    // MARK: - ENEMIES
    
    func createEnemy() {
        enemyNode = self.childNode(withName: "Enemy") as! SKSpriteNode

        enemyNode.zPosition = 10
        enemyNode.setScale(0.5)
        enemyNode.physicsBody = SKPhysicsBody(rectangleOf: captainNode.size)
        enemyNode.physicsBody?.categoryBitMask = enemyCategory
        enemyNode.physicsBody?.collisionBitMask = playerCategory
        enemyNode.physicsBody?.contactTestBitMask = playerCategory
        enemyNode.physicsBody?.allowsRotation = false
    }
    
    // MARK: - ENEMY CHASING
    
    func enemyMove() {
        let differenceX = enemyNode.position.x - captainNode.position.x
        let differenceY = enemyNode.position.y - captainNode.position.y
        let angle = atan2(differenceY, differenceX)
        let chaseSpeed: CGFloat = -0.7
        let vx = chaseSpeed * cos(angle)
        let vy = chaseSpeed * sin(angle)
        enemyNode.position.x += vx
        enemyNode.position.y += vy
    }
    
    func camera() {
        
        cam = SKCameraNode()
        cam.zPosition = 10
        cam.position = CGPoint(x: 0, y: 0)
        cam.setScale(3)
        
        addChild(cam)
        camera = cam
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node?.name
        let bodyB = contact.bodyB.node?.name
        
        print("ContactA = \(bodyA), ContactB \(bodyB)")
        
        if((bodyA == "Captain") && (bodyB == "Sign")) {

        } else {
            
        }
    }
    
    func connectVirtualController() {
        
        let controllerConfic = GCVirtualController.Configuration()
        controllerConfic.elements = [GCInputLeftThumbstick, GCInputButtonA]
        
        let controller = GCVirtualController(configuration: controllerConfic)
        controller.connect()
        virtualController = controller
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        // MARK: - Created controller
        
        captainPosx = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value)!)
        captainPosy = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.yAxis.value)!)
        
        // MARK: - ButtonA
        
        let buttonA = (virtualController?.controller?.extendedGamepad?.buttonA.isTouched)!
    
        // MARK: - Joystick Movement
        
        if !isRunning {
            if captainPosy <= -0.5 && captainPosx <= -0.5 { // GOING DOWN LEFT
                captainNode.position.y += -2.5
                captainNode.position.x += -2.5
                
                if !isAnimatingDownLeftDiagonal {
                    animation.animate(character: "captain", direction: .downLeft, characterNode: captainNode)
                    isAnimatingLeft = false
                    isAnimatingRight = false
                    isAnimatingUp = false
                    isAnimatingDown = false
                    isAnimatingUpLeftDiagonal = false
                    isAnimatingUpRightDiagonal = false
                    isAnimatingDownLeftDiagonal = true
                    isAnimatingDownRightDiagonal = false
                }
            } else if captainPosy <= -0.5 && captainPosx >= 0.5 { // GOING DOWN RIGHT
                captainNode.position.y += -2.5
                captainNode.position.x += 2.5
                
                if !isAnimatingDownRightDiagonal {
                    animation.animate(character: "captain", direction: .downRight, characterNode: captainNode)
                    isAnimatingLeft = false
                    isAnimatingRight = false
                    isAnimatingUp = false
                    isAnimatingDown = false
                    isAnimatingUpLeftDiagonal = false
                    isAnimatingUpRightDiagonal = false
                    isAnimatingDownLeftDiagonal = false
                    isAnimatingDownRightDiagonal = true
                }
            } else if captainPosy >= 0.5 && captainPosx <= -0.5 { // GOING UP Left
                captainNode.position.y += 2.5
                captainNode.position.x += -2.5
                
                if !isAnimatingUpLeftDiagonal {
                    animation.animate(character: "captain", direction: .upLeft, characterNode: captainNode)
()
                    isAnimatingLeft = false
                    isAnimatingRight = false
                    isAnimatingUp = false
                    isAnimatingDown = false
                    isAnimatingUpLeftDiagonal = true
                    isAnimatingUpRightDiagonal = false
                    isAnimatingDownLeftDiagonal = false
                    isAnimatingDownRightDiagonal = false
                }
            } else if captainPosy >= 0.5 && captainPosx >= 0.5 { // GOING UP RIGHT
                captainNode.position.y += 2.5
                captainNode.position.x += 2.5
                
                if !isAnimatingUpRightDiagonal {
                    animation.animate(character: "captain", direction: .upRight, characterNode: captainNode)
                    
                    isAnimatingLeft = false
                    isAnimatingRight = false
                    isAnimatingUp = false
                    isAnimatingDown = false
                    isAnimatingUpLeftDiagonal = false
                    isAnimatingUpRightDiagonal = true
                    isAnimatingDownLeftDiagonal = false
                    isAnimatingDownRightDiagonal = false
                }
            } else if captainPosx >= 0.5 { // GOING RIGHT
                captainNode.position.x += 5
                if !isAnimatingRight {
                    animation.animate(character: "captain", direction: .right, characterNode: captainNode)

                    isAnimatingLeft = false
                    isAnimatingRight = true
                    isAnimatingUp = false
                    isAnimatingDown = false
                    isAnimatingUpLeftDiagonal = false
                    isAnimatingUpRightDiagonal = false
                    isAnimatingDownLeftDiagonal = false
                    isAnimatingDownRightDiagonal = false
                }
                
            } else if captainPosx <= -0.5 { // GOING LEFT
                captainNode.position.x -= 5
                if !isAnimatingLeft {
                    animation.animate(character: "captain", direction: .left, characterNode: captainNode)
                    
                    isAnimatingLeft = true
                    isAnimatingRight = false
                    isAnimatingUp = false
                    isAnimatingDown = false
                    isAnimatingUpLeftDiagonal = false
                    isAnimatingUpRightDiagonal = false
                    isAnimatingDownLeftDiagonal = false
                    isAnimatingDownRightDiagonal = false
                }
            } else if captainPosy >= 0.5 { // GOING UP
                captainNode.position.y += 5
                
                if !isAnimatingUp {
                    animation.animate(character: "captain", direction: .up, characterNode: captainNode)

                    isAnimatingLeft = false
                    isAnimatingRight = false
                    isAnimatingUp = true
                    isAnimatingDown = false
                    isAnimatingUpLeftDiagonal = false
                    isAnimatingUpRightDiagonal = false
                    isAnimatingDownLeftDiagonal = false
                    isAnimatingDownRightDiagonal = false
                }
                
            } else if captainPosy <= -0.5 { // GOING DOWN
                
                captainNode.position.y -= 5
                
                if !isAnimatingDown {
                    animation.animate(character: "captain", direction: .down, characterNode: captainNode)

                    isAnimatingLeft = false
                    isAnimatingRight = false
                    isAnimatingUp = false
                    isAnimatingDown = true
                    isAnimatingUpLeftDiagonal = false
                    isAnimatingUpRightDiagonal = false
                    isAnimatingDownLeftDiagonal = false
                    isAnimatingDownRightDiagonal = false
                }
            } else {
                captainNode.removeAllActions()
                
                isAnimatingLeft = false
                isAnimatingRight = false
                isAnimatingUp = false
                isAnimatingDown = false
                isAnimatingUpLeftDiagonal = false
                isAnimatingUpRightDiagonal = false
                isAnimatingDownLeftDiagonal = false
                isAnimatingDownRightDiagonal = false
                
                
            }
            // MARK: - Cam with Player
            
            cam.position.x = captainNode.position.x
            cam.position.y = captainNode.position.y
        }
    }
}

