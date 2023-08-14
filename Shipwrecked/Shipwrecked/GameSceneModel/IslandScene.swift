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


class IslandScene: SKScene, SKPhysicsContactDelegate, ObservableObject {
    
    @MainActor var joyconAngle = 0
    @Published var currentHealth = 0
    @Published var currentPlayer: Player?
    @Published var currentWeapon: Weapon?
    @Published var inventory = [InventoryItem(name: "Apple", imageName: "Apple")]
    
    
    // MARK: Instances
    
    var animation = AnimationManager.instance
    var node = SpriteNodeManager.instance
    var tileMap = TileMapManager.instance
    
    // MARK: - PlayerNode
    
    var currentPlayerNode = SKSpriteNode()
    
    var playerPosx: CGFloat = 0
    var playerPosy: CGFloat = 0
    
    // MARK: - Combat
    
    var meleeCombatBool = false
    var rangerCombatBool = false
    
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
    
    let rangerCategory: UInt32 = 0x10000
    let meleeCategory: UInt32 = 0x100000
    
    let signCategory: UInt32 = 0x1000000
    
    let triggerCategory: UInt32 = 0x1000000
    let skullCategory: UInt32 = 0x10000000
    
    var testNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        // MARK: - BEACH
        
        tileMap.createTileMapNode(tileMapSceneName: "MountainsOuter", selfCategory: wallCategory, collisionCategory: playerCategory, zPosition: 1, scene: self)
        tileMap.createTileMapNode(tileMapSceneName: "WaterOuter", selfCategory: wallCategory, collisionCategory: playerCategory, zPosition: 1, scene: self)
        tileMap.createTileMapNode(tileMapSceneName: "Sand", selfCategory: pathCategory, collisionCategory: playerCategory, zPosition: 0, scene: self)
//        tileMap.createTileMapNode(tileMapSceneName: "Palms", selfCategory: wallCategory, collisionCategory: playerCategory, zPosition: 1, scene: self)

        // MARK: - SignNodes
        
        createTrigger(withName: "test", withNode: testNode)
        
        
        // MARK: - Characters
        
        createPlayer()
        
        // MARK: - Camera/Controller
        
        camera()
        connectVirtualController()
    }
    
    func updateAngle(isAttacking: Bool, degree: Int) {
        self.joyconAngle = degree
        self.isShootin = isAttacking
        self.isSwingin = isAttacking
    }
    
    // MARK: - TRANSITION FUNCS
    
    func transitionToJungleScene() {
        GameData.shared.currentHealth = self.currentHealth
        GameData.shared.currentPlayer = self.currentPlayer
        GameData.shared.currentPlayerPositionX = -1700
        GameData.shared.currentPlayerPositionY = 700
        
        GameData.shared.islandSceneActive = false
        GameData.shared.caveSceneActive = false
        GameData.shared.volcanoSceneActive = false
        
        GameData.shared.jungleSceneActive = true
    }
    
    func transitionToCaveScene() {
        GameData.shared.currentHealth = self.currentHealth
        GameData.shared.currentPlayer = self.currentPlayer
        GameData.shared.currentPlayerPositionX = 0
        GameData.shared.currentPlayerPositionY = -2000
        
        GameData.shared.jungleSceneActive = false
        GameData.shared.volcanoSceneActive = false
        GameData.shared.islandSceneActive = false
        
        GameData.shared.caveSceneActive = true
        
    }
    
    // MARK: - Character
    
    func createPlayer() {
        
        currentPlayerNode = .init(imageNamed: currentPlayer?.character ?? "nil")
        
        currentPlayerNode.position = CGPoint(x: 0, y: -2000)
        currentPlayerNode.zPosition = 5
        currentPlayerNode.setScale(0.5)
        currentPlayerNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: currentPlayerNode.size.width / 2, height: currentPlayerNode.size.height / 10))
        currentPlayerNode.physicsBody?.categoryBitMask = playerCategory
        currentPlayerNode.physicsBody?.collisionBitMask = wallCategory
        currentPlayerNode.physicsBody?.contactTestBitMask = wallCategory
        currentPlayerNode.physicsBody?.allowsRotation = false
        
        self.addChild(currentPlayerNode)
    }
    
    // MARK: - EnemieStorage
    
    var enemyDictionary: [String : (health: Int, strength: Int)] = [
        "Test" : (health: 10, strength: 10)
    ]
   
    // MARK: - ENEMY TRIGGER
    
    func createTrigger(withName: String, withNode: SKSpriteNode) {
        
        var nodeTrigger = withNode
        
        nodeTrigger = self.childNode(withName: withName) as! SKSpriteNode
        
        nodeTrigger.name = withName
        nodeTrigger.zPosition = -1
        nodeTrigger.physicsBody = SKPhysicsBody(rectangleOf: nodeTrigger.size)
        nodeTrigger.physicsBody?.categoryBitMask = triggerCategory
        nodeTrigger.physicsBody?.collisionBitMask = playerCategory
        nodeTrigger.physicsBody?.contactTestBitMask = playerCategory
        nodeTrigger.physicsBody?.allowsRotation = false
        nodeTrigger.physicsBody?.isDynamic = false
    }
    
    // MARK: - COMBAT
    
    @objc func gunFire() {
        bulletNode = .init(imageNamed: "Bullet")
        
        bulletNode.name = "Bullet"
        bulletNode.position = CGPoint(x: currentPlayerNode.position.x, y: currentPlayerNode.position.y )
        bulletNode.zPosition = 5
        bulletNode.setScale(0.1)
        bulletNode.zRotation = CGFloat(joyconAngle.degreesToRadians)
        bulletNode.physicsBody = SKPhysicsBody(rectangleOf: bulletNode.size)
        bulletNode.physicsBody?.affectedByGravity = false
        bulletNode.physicsBody?.categoryBitMask = rangerCategory
        bulletNode.physicsBody?.contactTestBitMask = enemyCategory
        bulletNode.physicsBody?.collisionBitMask = enemyCategory
        bulletNode.physicsBody?.isDynamic = false
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
        swordNode.zPosition = 5
        swordNode.zRotation = CGFloat(joyconAngle.degreesToRadians)
        swordNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: swordNode.size.width / 3 , height: swordNode.size.height * 1.6))
        swordNode.physicsBody?.affectedByGravity = false
        swordNode.physicsBody?.categoryBitMask = meleeCategory
        swordNode.physicsBody?.contactTestBitMask = enemyCategory
        swordNode.physicsBody?.collisionBitMask = enemyCategory
        swordNode.physicsBody?.isDynamic = false
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
    
    // MARK: - ENEMY Creation
    
    func enemyMove(enemyName: String, node: SKSpriteNode, enemySceneName: String, healthBarNode: SKSpriteNode) {
        
        var nodeEnemy = node
        var healthNode = healthBarNode
        
        let healthBarArray = ["Skull3","1HealthBarEnemy","2HealthBarEnemy","3HealthBarEnemy"]
        
        if let healthIndex = enemyDictionary[enemySceneName]?.health {
            if healthIndex >= 0 {
                
                if healthIndex >= 1 {
                    
                    nodeEnemy = self.childNode(withName: enemySceneName) as! SKSpriteNode
                    
                    nodeEnemy.zPosition = 5
                    nodeEnemy.setScale(0.5)
                    nodeEnemy.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: nodeEnemy.size.width / 2 , height: nodeEnemy.size.height) )
                    nodeEnemy.physicsBody?.categoryBitMask = enemyCategory
                    nodeEnemy.physicsBody?.collisionBitMask = rangerCategory | meleeCategory | wallCategory | playerCategory | enemyCategory
                    nodeEnemy.physicsBody?.contactTestBitMask = rangerCategory | meleeCategory  | wallCategory | playerCategory | enemyCategory
                    nodeEnemy.physicsBody?.allowsRotation = false
                }
                
                healthNode = self.childNode(withName: "\(enemySceneName)HealthBar") as! SKSpriteNode
                
                healthNode.texture = SKTexture(imageNamed: healthBarArray[healthIndex])
                if healthIndex >= 1 {
                    healthNode.position = CGPoint(x: nodeEnemy.position.x, y: nodeEnemy.position.y + 70 )
                }
                healthNode.setScale(0.5)
                healthNode.zPosition = 6
                healthNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: healthNode.size.width / 3 , height: healthNode.size.height * 1.6))
                healthNode.physicsBody?.categoryBitMask = skullCategory
                healthNode.physicsBody?.collisionBitMask = playerCategory
                healthNode.physicsBody?.contactTestBitMask = playerCategory
                healthNode.physicsBody?.isDynamic = false
                healthNode.physicsBody?.allowsRotation = false
                
                let differenceX = nodeEnemy.position.x - currentPlayerNode.position.x
                let differenceY = nodeEnemy.position.y - currentPlayerNode.position.y
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
                        animation.animate(character: enemyName, direction: .upRight, characterNode: nodeEnemy)
                        setAnimateBoolsEnemy(direction: .upRight)
                    }
                } else if angle2 < pi/2 { // UP
                    if !isAnimatingUpEnemy {
                        animation.animate(character: enemyName, direction: .up, characterNode: nodeEnemy)
                        setAnimateBoolsEnemy(direction: .up)
                    }
                } else if angle2 < 3 * pi/4 { // UPLEFT
                    if !isAnimatingUpLeftDiagonalEnemy {
                        animation.animate(character: enemyName, direction: .upLeft, characterNode: nodeEnemy)
                        setAnimateBoolsEnemy(direction: .upLeft)
                    }
                } else if angle2 < pi { // LEFT
                    if !isAnimatingLeftEnemy {
                        animation.animate(character: enemyName, direction: .left, characterNode: nodeEnemy)
                        setAnimateBoolsEnemy(direction: .left)
                    }
                } else if angle2 < 5 * pi/4 { // DOWNLEFT
                    if !isAnimatingDownLeftDiagonalEnemy {
                        animation.animate(character: enemyName, direction: .downLeft, characterNode: nodeEnemy)
                        setAnimateBoolsEnemy(direction: .downLeft)
                    }
                } else if angle2 < 3 * pi/2 { // DOWN
                    if !isAnimatingDownEnemy {
                        animation.animate(character: enemyName, direction: .down, characterNode: nodeEnemy)
                        setAnimateBoolsEnemy(direction: .down)
                    }
                } else if angle2 < 7 * pi/4 { // DOWNRIGHT
                    if !isAnimatingDownRightDiagonalEnemy {
                        animation.animate(character: enemyName, direction: .downRight, characterNode: nodeEnemy)
                        setAnimateBoolsEnemy(direction: .downRight)
                    }
                } else { // RIGHT
                    if !isAnimatingRightEnemy {
                        animation.animate(character: enemyName, direction: .right, characterNode: nodeEnemy)
                        setAnimateBoolsEnemy(direction: .right)
                    }
                }
                
                nodeEnemy.position.x += vx
                nodeEnemy.position.y += vy
            }
        }
    }
    
    // MARK: - Combat Contacts
    
    func contactedEnemyMelee(enemyNode: SKNode, contactName: String) {
        if enemyDictionary[contactName]!.health < 1 {
            enemyNode.removeAllActions()
            enemyNode.removeFromParent()
            enemyDictionary[contactName]?.health -= 1
        }
        if meleeCombatBool {
            enemyDictionary[contactName]?.health -= 1
            meleeCombatBool = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
                meleeCombatBool = false
            }
        }
    }
    
    func contactedEnemyRanger(enemyNode: SKNode, contactName: String) {
        if !rangerCombatBool {
            enemyDictionary[contactName]?.health -= 1
            rangerCombatBool = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
                rangerCombatBool = false
            }
        }
        if enemyDictionary[contactName]!.health < 1 {
            enemyNode.removeAllActions()
            enemyNode.removeFromParent()
        }
        
    }
    
    func contactedRip(graveNode: SKNode, enemyKey: String) {
        if enemyDictionary[enemyKey]!.health == 0  {
            enemyDictionary[enemyKey]?.health -= 1
            graveNode.removeAllActions()
            graveNode.removeFromParent()
        }
    }
    
    // MARK: - CAMERA
    
    func camera() {
        
        cam = SKCameraNode()
        cam.zPosition = 10
        cam.position = CGPoint(x: 0, y: 0)
        cam.setScale(2)
        
        addChild(cam)
        camera = cam
    }
    
    // MARK: - PHYSICS INTERACTION
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactA = contact.bodyA.node?.name
        let contactB = contact.bodyB.node?.name
        
        let bodyA = contact.bodyA.node?.physicsBody?.categoryBitMask
        let bodyB = contact.bodyB.node?.physicsBody?.categoryBitMask
        
        print("Contact A\(contactA) Contact B \(bodyB)")
        
        // MARK: - Enemy Health Contact
        
        if bodyA == enemyCategory && bodyB == meleeCategory {
            contactedEnemyMelee(enemyNode: contact.bodyA.node ?? SKNode(), contactName: contactA ?? "nil")
        }
        if bodyB == enemyCategory && bodyA == meleeCategory {
            contactedEnemyMelee(enemyNode: contact.bodyB.node ?? SKNode(), contactName: contactB ?? "nil")
        }

        
        if bodyA == enemyCategory && bodyB == rangerCategory {
            contactedEnemyRanger(enemyNode: contact.bodyA.node ?? SKNode(), contactName: contactA ?? "nil")
            contact.bodyB.node?.removeFromParent()
        }
        if bodyB == enemyCategory && bodyA == rangerCategory {
            contactedEnemyRanger(enemyNode: contact.bodyB.node ?? SKNode(), contactName: contactB ?? "nil")
            contact.bodyA.node?.removeFromParent()
        }
        
        // MARK: - Scenes
        
        
        
        // MARK: - CAVE TRIGGERS
        
        if contactA == ("test") && bodyB == playerCategory {
            func realTransition() {
                let caveScene = SKScene(fileNamed: "CaveScene.sks") as! CaveScene
                        let transition = SKTransition.fade(withDuration: 0.5) // You can choose the transition effect and duration
                        
                        self.view?.presentScene(caveScene, transition: transition)
            }

        }
        if bodyA == playerCategory && contactB == ("test") {
            transitionToCaveScene()

        }
//        if contactA == ("Cave2Trigger") && bodyB == playerCategory {
//            cave2TriggerOn = true
//        }
//        if contactA == ("Cave3Trigger") && bodyB == playerCategory {
//            cave3TriggerOn = true
//        }
//        if contactA == ("Cave4Trigger") && bodyB == playerCategory {
//            cave4TriggerOn = true
//        }
//        if contactA == ("Cave5Trigger") && bodyB == playerCategory {
//            cave5TriggerOn = true
//        }
        
        
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
        
        if !isFiring {
            startShooting()
        }
        
        //        if !isStrikin {
        //            startSwinging()
        //        }
        //
        // MARK: - CaveEnemyActivate
            
//            if cave1TriggerOn {
//                enemyMove(enemyName: "blueWarrior", node: cave1Enemy1, enemySceneName: "Cave1Enemy1", healthBarNode: cave1Enemy1HealthNode)
//                enemyMove(enemyName: "blueWarrior", node: cave1Enemy2, enemySceneName: "Cave1Enemy2", healthBarNode: cave1Enemy2HealthNode)
//                enemyMove(enemyName: "blueWarrior", node: cave1Enemy3, enemySceneName: "Cave1Enemy3", healthBarNode: cave1Enemy3HealthNode)
//                enemyMove(enemyName: "blueWarrior", node: cave1Enemy4, enemySceneName: "Cave1Enemy4", healthBarNode: cave1Enemy4HealthNode)
//            }
           
        // MARK: - Created controller
        
        playerPosx = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value)!)
        playerPosy = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.yAxis.value)!)
        
        // MARK: - Joystick Movement
        
        if playerPosy <= -0.5 && playerPosx <= -0.5 { // GOING DOWN LEFT
            currentPlayerNode.position.y += -2.5
            currentPlayerNode.position.x += -2.5
            
            if !isAnimatingDownLeftDiagonalPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .downLeft, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .downLeft)
            }
        } else if playerPosy <= -0.5 && playerPosx >= 0.5 { // GOING DOWN RIGHT
            currentPlayerNode.position.y += -2.5
            currentPlayerNode.position.x += 2.5
            
            if !isAnimatingDownRightDiagonalPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .downRight, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .downRight)
            }
        } else if playerPosy >= 0.5 && playerPosx <= -0.5 { // GOING UP Left
            currentPlayerNode.position.y += 2.5
            currentPlayerNode.position.x += -2.5
            
            if !isAnimatingUpLeftDiagonalPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .upLeft, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .upLeft)
            }
        } else if playerPosy >= 0.5 && playerPosx >= 0.5 { // GOING UP RIGHT
            currentPlayerNode.position.y += 2.5
            currentPlayerNode.position.x += 2.5
            
            if !isAnimatingUpRightDiagonalPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .upRight, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .upRight)
            }
        } else if playerPosx >= 0.5 { // GOING RIGHT
            currentPlayerNode.position.x += 5
            if !isAnimatingRightPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .right, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .right)
            }
            
        } else if playerPosx <= -0.5 { // GOING LEFT
            currentPlayerNode.position.x -= 5
            if !isAnimatingLeftPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .left, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .left)
            }
        } else if playerPosy >= 0.5 { // GOING UP
            currentPlayerNode.position.y += 5
            
            if !isAnimatingUpPlayer {
                animation.animate(character: currentPlayer?.weapon ?? "nil", direction: .up, characterNode: currentPlayerNode)
                
                setAnimateBoolsPlayer(direction: .up)
            }
            
        } else if playerPosy <= -0.5 { // GOING DOWN
            
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
        
        //        print("\(enemyDictionary["Cave1Enemy1"]?.health)")
        
        
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
