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
    
    var animation = AnimationManager.instance
    var node = SpriteNodeManager.instance
    var tileMap = TileMapManager.instance
    
    var captainNode = SKSpriteNode()
    var enemyNode = SKSpriteNode()
    var signNode = SKSpriteNode()
    
    // Leo Stuff
    var currentWeapon: Weapon = Weapon(name: "Sentient Stick", image: Image("SentientStickFront"), damage: 6, isGun: false)
    let wSentientStick: Weapon = Weapon(name: "Sentient Stick", image: Image("SentientStickFront"), damage: 6, isGun: false)
    let wGun: Weapon = Weapon(name: "Musket", image: Image("CannonBall"), damage: 11, isGun: true)
    let wSword: Weapon = Weapon(name: "Sword", image: Image("Cutlass"), damage: 13, isGun: false)
    
    
    var captainPosx: CGFloat = 0
    var captainPosy: CGFloat = 0
    
    var direction: Direction = .right
    
    var cam: SKCameraNode!
    var virtualController: GCVirtualController?
    
    let wallCategory: UInt32 = 0x1
    let playerCategory: UInt32 = 0x10
    let signCategory: UInt32 = 0x100
    let enemyCategory: UInt32 = 0x1000
    
    var isAnimatingLeftPlayer = false
    var isAnimatingRightPlayer = false
    var isAnimatingUpPlayer = false
    var isAnimatingDownPlayer = false
    var isAnimatingUpRightDiagonalPlayer = false
    var isAnimatingUpLeftDiagonalPlayer = false
    var isAnimatingDownRightDiagonalPlayer = false
    var isAnimatingDownLeftDiagonalPlayer = false
    
    var isAnimatingLeftEnemy = false
    var isAnimatingRightEnemy = false
    var isAnimatingUpEnemy = false
    var isAnimatingDownEnemy = false
    var isAnimatingUpRightDiagonalEnemy = false
    var isAnimatingUpLeftDiagonalEnemy = false
    var isAnimatingDownRightDiagonalEnemy = false
    var isAnimatingDownLeftDiagonalEnemy = false
    
    let blank: UInt32 = 0x10000
    let blank2: UInt32 = 0x100000
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        // MARK: - TileMapNodes
        
                tileMap.createTileMapNode(tileMapSceneName: "Mountains", selfCategory: wallCategory, collisionCategory: playerCategory, scene: self)
        //
                tileMap.createTileMapNode(tileMapSceneName: "Water", selfCategory: wallCategory, collisionCategory: playerCategory, scene: self)
        //
                tileMap.createTileMapNode(tileMapSceneName: "Palms", selfCategory: wallCategory, collisionCategory: playerCategory, scene: self)
        
        // MARK: - SignNodes
        
        
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
        captainNode.setScale(0.8)
        captainNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: captainNode.size.width / 2, height: captainNode.size.height / 2))
        captainNode.physicsBody?.categoryBitMask = playerCategory
        captainNode.physicsBody?.collisionBitMask = wallCategory
        captainNode.physicsBody?.contactTestBitMask = wallCategory
        captainNode.physicsBody?.allowsRotation = false
    }
    
    // MARK: - ENEMIES
    
    func createEnemy() {
        enemyNode = self.childNode(withName: "Enemy") as! SKSpriteNode
        
        enemyNode.zPosition = 10
        enemyNode.setScale(0.8)
        enemyNode.physicsBody = SKPhysicsBody(rectangleOf: enemyNode.size)
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
        let chaseSpeed: CGFloat = -5
        let vx = chaseSpeed * cos(angle)
        let vy = chaseSpeed * sin(angle)
        
        let pi = Double.pi
        
        var angle2 = angle + 7 * pi/8
        
        if angle2 < 0 {
            angle2 = angle2 + 2 * pi
        }
        
        if angle2 < pi/4 { // UPRIGHT
            if !isAnimatingUpRightDiagonalEnemy {
                animation.animate(character: "gunner", direction: .upRight, characterNode: enemyNode)
                setAnimateBoolsEnemy(direction: .upRight)
            }
        } else if angle2 < pi/2 { // UP
            if !isAnimatingUpEnemy {
                animation.animate(character: "gunner", direction: .up, characterNode: enemyNode)
                setAnimateBoolsEnemy(direction: .up)
            }
        } else if angle2 < 3 * pi/4 { // UPLEFT
            if !isAnimatingUpLeftDiagonalEnemy {
                animation.animate(character: "gunner", direction: .upLeft, characterNode: enemyNode)
                setAnimateBoolsEnemy(direction: .upLeft)
            }
        } else if angle2 < pi { // LEFT
            if !isAnimatingLeftEnemy {
                animation.animate(character: "gunner", direction: .left, characterNode: enemyNode)
                setAnimateBoolsEnemy(direction: .left)
            }
        } else if angle2 < 5 * pi/4 { // DOWNLEFT
            if !isAnimatingDownLeftDiagonalEnemy {
                animation.animate(character: "gunner", direction: .downLeft, characterNode: enemyNode)
                setAnimateBoolsEnemy(direction: .downLeft)
            }
        } else if angle2 < 3 * pi/2 { // DOWN
            if !isAnimatingDownEnemy {
                animation.animate(character: "gunner", direction: .down, characterNode: enemyNode)
                setAnimateBoolsEnemy(direction: .down)
            }
        } else if angle2 < 7 * pi/4 { // DOWNRIGHT
            if !isAnimatingDownRightDiagonalEnemy {
                animation.animate(character: "gunner", direction: .downRight, characterNode: enemyNode)
                setAnimateBoolsEnemy(direction: .downRight)
            }
        } else { // RIGHT
            if !isAnimatingRightEnemy {
                animation.animate(character: "gunner", direction: .right, characterNode: enemyNode)
                setAnimateBoolsEnemy(direction: .right)
            }
        }
        
        enemyNode.position.x += vx
        enemyNode.position.y += vy
    }
    
    // MARK: - CAMERA
    
    func camera() {
        
        cam = SKCameraNode()
        cam.zPosition = 10
        cam.position = CGPoint(x: 0, y: 0)
        cam.setScale(4)
        
        addChild(cam)
        camera = cam
    }
    
    // MARK: - PHYSICS INTERACTION
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node?.name
        let bodyB = contact.bodyB.node?.name
        
        print("ContactA = \(bodyA), ContactB \(bodyB)")
        
        if((bodyA == "Captain") && (bodyB == "Sign")) {
            
        } else {
            
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
    
    override func update(_ currentTime: TimeInterval) {
        
        // MARK: - Created controller
        
        captainPosx = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value)!)
        captainPosy = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.yAxis.value)!)
        
        // MARK: - ButtonA
        
        let buttonA = (virtualController?.controller?.extendedGamepad?.buttonA.isTouched)!
        
        // MARK: - Joystick Movement
        
        if captainPosy <= -0.5 && captainPosx <= -0.5 { // GOING DOWN LEFT
            captainNode.position.y += -2.5
            captainNode.position.x += -2.5
            
            if !isAnimatingDownLeftDiagonalPlayer {
                animation.animate(character: "captain", direction: .downLeft, characterNode: captainNode)
                
                setAnimateBoolsPlayer(direction: .downLeft)
            }
        } else if captainPosy <= -0.5 && captainPosx >= 0.5 { // GOING DOWN RIGHT
            captainNode.position.y += -2.5
            captainNode.position.x += 2.5
            
            if !isAnimatingDownRightDiagonalPlayer {
                animation.animate(character: "captain", direction: .downRight, characterNode: captainNode)
                
                setAnimateBoolsPlayer(direction: .downRight)
            }
        } else if captainPosy >= 0.5 && captainPosx <= -0.5 { // GOING UP Left
            captainNode.position.y += 2.5
            captainNode.position.x += -2.5
            
            if !isAnimatingUpLeftDiagonalPlayer {
                animation.animate(character: "captain", direction: .upLeft, characterNode: captainNode)
                
                setAnimateBoolsPlayer(direction: .upLeft)
            }
        } else if captainPosy >= 0.5 && captainPosx >= 0.5 { // GOING UP RIGHT
            captainNode.position.y += 2.5
            captainNode.position.x += 2.5
            
            if !isAnimatingUpRightDiagonalPlayer {
                animation.animate(character: "captain", direction: .upRight, characterNode: captainNode)
                
                setAnimateBoolsPlayer(direction: .upRight)
            }
        } else if captainPosx >= 0.5 { // GOING RIGHT
            captainNode.position.x += 5
            if !isAnimatingRightPlayer {
                animation.animate(character: "captain", direction: .right, characterNode: captainNode)
                
                setAnimateBoolsPlayer(direction: .right)
            }
            
        } else if captainPosx <= -0.5 { // GOING LEFT
            captainNode.position.x -= 10
            if !isAnimatingLeftPlayer {
                animation.animate(character: "captain", direction: .left, characterNode: captainNode)
                
                setAnimateBoolsPlayer(direction: .left)
            }
        } else if captainPosy >= 0.5 { // GOING UP
            captainNode.position.y += 5
            
            if !isAnimatingUpPlayer {
                animation.animate(character: "captain", direction: .up, characterNode: captainNode)
                
                setAnimateBoolsPlayer(direction: .up)
            }
            
        } else if captainPosy <= -0.5 { // GOING DOWN
            
            captainNode.position.y -= 5
            
            if !isAnimatingDownPlayer {
                animation.animate(character: "captain", direction: .down, characterNode: captainNode)
                
                setAnimateBoolsPlayer(direction: .down)
            }
        } else {
            captainNode.removeAllActions()
            
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
        
        cam.position.x = captainNode.position.x
        cam.position.y = captainNode.position.y
        
        // MARK: - ENEMY CHASE
        
        enemyMove()
    }
    
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


extension GameScene {
    
    private struct Constants {
        
    }
    
}

