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
    @MainActor var leftJoyconAngle: Double = 0
    
    var isMoving = false
    static var hasLoaded = false
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
    
    var gunNode = SKSpriteNode()
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
    
    
    // MARK: - Food
    
        let apple1 = SKSpriteNode()
        let apple2 = SKSpriteNode()
        let watermelon1 = SKSpriteNode()
    
    let stickNode = SKSpriteNode()
    
    
    // MARK: - Camera/Controller
    
    var cam: SKCameraNode!
    
    // MARK: - Crew
    
    var gunnerCrew = SKSpriteNode()
    var kevinCrew = SKSpriteNode()
    var captainCrew = SKSpriteNode()
    
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
    
    // MARK: - Transition Nodes
    
    var caveEntrance = SKSpriteNode()
    var jungleEntrance = SKSpriteNode()
    var volcanoEntrance = SKSpriteNode()
    
    // MARK: - PHYSICS CATEGORIES
    
    let wallCategory: UInt32 = 0x1
    let pathCategory: UInt32 = 0x10
    
    let playerCategory: UInt32 = 0x100
    let enemyCategory: UInt32 = 0x1000
    
    let rangerCategory: UInt32 = 0x10000
    let meleeCategory: UInt32 = 0x100000
    
    let signCategory: UInt32 = 0x1000000
    let appleCategory: UInt32 = 0x5000
    
    let triggerCategory: UInt32 = 0x1000000
    let skullCategory: UInt32 = 0x10000000
    
    var boat = SKSpriteNode()
    
    
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        // MARK: - BEACH
        
        if !IslandScene.hasLoaded {
            tileMap.createTileMapNode(tileMapSceneName: "MountainsOuter", selfCategory: wallCategory, collisionCategory: playerCategory, zPosition: 1, scene: self)
            tileMap.createTileMapNode(tileMapSceneName: "WaterOuter", selfCategory: wallCategory, collisionCategory: playerCategory, zPosition: 1, scene: self)
            tileMap.createTileMapNode(tileMapSceneName: "Sand", selfCategory: pathCategory, collisionCategory: playerCategory, zPosition: 0, scene: self)
            tileMap.createTileMapNode(tileMapSceneName: "Assets", selfCategory: wallCategory, collisionCategory: playerCategory, zPosition: 1, scene: self)
            
        
        // MARK: - SignNodes
        

        createTrigger(withName: "CaveEntrance", withNode: caveEntrance)
        createTrigger(withName: "JungleEntrance", withNode: jungleEntrance)
        createTrigger(withName: "VolcanoEntrance", withNode: volcanoEntrance)
        
        // MARK: - FoodPickups
        
    // MARK: - FoodPickups
            
            node.createSpriteNode(spriteNode: apple1, sceneNodeName: "Apple1", selfCategory: skullCategory, collisionContactCategory: playerCategory, scene: self, scale: 1)
            node.createSpriteNode(spriteNode: watermelon1, sceneNodeName: "Watermelon1", selfCategory: skullCategory, collisionContactCategory: playerCategory, scene: self, scale: 1)
            
            node.createSpriteNode(spriteNode: boat, sceneNodeName: "Boat", selfCategory: signCategory, collisionContactCategory: playerCategory, scene: self, scale: 1.0)
            
        
        // MARK: - Camera/Controller
        
        camera()
            IslandScene.hasLoaded = true
        }
        
        // MARK: - Characters
        
        createPlayer()
        SoundManager.instance.playMusic(sound: .IslandTheme,volume: 0.5, loops: 5)
    }
        
    
    func updateAngle(isAttacking: Bool, degree: Int) {
        self.joyconAngle = degree
        self.isShootin = isAttacking
        self.isSwingin = isAttacking
    }
    
    func updateMovement(degree: Int, isMoving: Bool) {
        self.leftJoyconAngle = Double(degree)
        self.isMoving = isMoving
    }
    
    // MARK: - TRANSITION FUNCS
    
    func transitionToJungleScene() {
        currentPlayerNode.removeFromParent()
        GameData.shared.currentLevel = .jungleScene
        GameData.shared.currentPlayerPositionX = -1700
        GameData.shared.currentPlayerPositionY = 700
        
        GameData.shared.gunnerPlayerPositionX = -1700
        GameData.shared.gunnerPlayerPositionY = 700
        
        GameData.shared.captainPlayerPositionX = -1700
        GameData.shared.captainPlayerPositionY = 700
        
    }
    func transitionToCaveScene() {
        currentPlayerNode.removeFromParent()
        GameData.shared.currentLevel = .caveScene
        GameData.shared.currentPlayerPositionX = 0
        GameData.shared.currentPlayerPositionY = -1800
        
        GameData.shared.kevinPlayerPositionX = 0
        GameData.shared.kevinPlayerPositionY = -1800
        
        GameData.shared.captainPlayerPositionX = 0
        GameData.shared.captainPlayerPositionY = -1800
    }
    func transitionToVolcanoScene() {
        currentPlayerNode.removeFromParent()
        GameData.shared.currentLevel = .volcanoScene
        GameData.shared.currentPlayerPositionX = -1700
        GameData.shared.currentPlayerPositionY = 1300
        
        GameData.shared.gunnerPlayerPositionX = -1700
        GameData.shared.gunnerPlayerPositionY = 900
        
        GameData.shared.kevinPlayerPositionX = -1700
        GameData.shared.kevinPlayerPositionY = 900
    }
    
    // MARK: - Character
    
    func createPlayer() {
        
        currentPlayerNode = .init(imageNamed: GameData.shared.currentPlayer?.character ?? "nil")
        
        currentPlayerNode.position = CGPoint(x: GameData.shared.currentPlayerPositionX, y: GameData.shared.currentPlayerPositionY)
        currentPlayerNode.zPosition = CGFloat(SceneConstants.playerZposition)
        currentPlayerNode.setScale(SceneConstants.playerScale)
        currentPlayerNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: currentPlayerNode.size.width / SceneConstants.playerWidth, height: currentPlayerNode.size.height / SceneConstants.playerHeight))
        currentPlayerNode.physicsBody?.categoryBitMask = playerCategory
        currentPlayerNode.physicsBody?.collisionBitMask = wallCategory
        currentPlayerNode.physicsBody?.contactTestBitMask = wallCategory
        currentPlayerNode.physicsBody?.allowsRotation = false
        
        self.addChild(currentPlayerNode)
    }
    
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
        gunNode = .init(imageNamed: GameData.shared.currentWeapon?.imageName ?? "nil")
        
        gunNode.zPosition = SceneConstants.gunZPosition
        gunNode.setScale(SceneConstants.gunScale)
        gunNode.zRotation = CGFloat(joyconAngle.degreesToRadians)
        gunNode.physicsBody = SKPhysicsBody(rectangleOf: gunNode.size)
        gunNode.physicsBody?.affectedByGravity = false
        gunNode.physicsBody?.isDynamic = false
        gunNode.physicsBody?.categoryBitMask = pathCategory
        gunNode.physicsBody?.contactTestBitMask = enemyCategory
        gunNode.physicsBody?.collisionBitMask = enemyCategory
        gunNode.anchorPoint = CGPoint(x: SceneConstants.gunAnchorX,y: SceneConstants.gunAnchorY)
        
        let gun = SKAction.move(to: CGPoint(
            x: cos(gunNode.zRotation) + gunNode.position.x,
            y: sin(gunNode.zRotation) + gunNode.position.y)
                                ,duration: SceneConstants.gunDuration)
        let deleteGun = SKAction.removeFromParent()
        
        let gunSeq = SKAction.sequence([gun, deleteGun])
        
        bulletNode = .init(imageNamed: SceneConstants.bulletImage)
        
        bulletNode.name = SceneConstants.bulletImage
        bulletNode.zPosition = SceneConstants.bulletZPosition
        bulletNode.position = CGPoint(x: currentPlayerNode.position.x, y: currentPlayerNode.position.y )
        bulletNode.setScale(SceneConstants.bulletScale)
        bulletNode.zRotation = CGFloat(joyconAngle.degreesToRadians)
        bulletNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bulletNode.size.width / SceneConstants.bulletWidth , height: bulletNode.size.height * SceneConstants.bulletHeight))
        bulletNode.physicsBody?.affectedByGravity = false
        bulletNode.physicsBody?.categoryBitMask = rangerCategory
        bulletNode.physicsBody?.contactTestBitMask = enemyCategory
        bulletNode.physicsBody?.collisionBitMask = enemyCategory
        bulletNode.physicsBody?.isDynamic = false
        bulletNode.anchorPoint = CGPoint(x:SceneConstants.bulletAnchorX,y: SceneConstants.bulletAnchorY)
        
        
        let shoot = SKAction.move(to: CGPoint(
            x: SceneConstants.projecticleDistance * cos(bulletNode.zRotation) + bulletNode.position.x,
            y: SceneConstants.projecticleDistance * sin(bulletNode.zRotation) + bulletNode.position.y)
                                  ,duration: SceneConstants.projecticleDistance)
        let deleteBullet = SKAction.removeFromParent()
        
        let bulletSeq = SKAction.sequence([shoot, deleteBullet])
        if isShootin && GameData.shared.currentWeapon?.isRanged ?? false {
            SoundManager.instance.playCombat(sound: .gunFire, volume: SceneConstants.gunFireVolume)
            currentPlayerNode.addChild(gunNode)
            self.addChild(bulletNode)
            bulletNode.run(bulletSeq)
            gunNode.run(gunSeq)
        }
    }
    
    func startShooting() {
        shootTimer = Timer.scheduledTimer(timeInterval: SceneConstants.bulletTimer, target: self, selector: #selector(gunFire), userInfo: nil, repeats: true)
        isFiring = true
    }
    
    @objc func swing() {
        swordNode = .init(imageNamed: GameData.shared.currentWeapon?.imageName ?? "nona")
    
        swordNode.setScale(SceneConstants.meleeScale)
        swordNode.zPosition = SceneConstants.meleeZPosition
        swordNode.zRotation = CGFloat(joyconAngle.degreesToRadians)
        swordNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: swordNode.size.width / SceneConstants.meleeWidth , height: swordNode.size.height * SceneConstants.meleeHeight))
        swordNode.physicsBody?.affectedByGravity = false
        swordNode.physicsBody?.categoryBitMask = meleeCategory
        swordNode.physicsBody?.contactTestBitMask = enemyCategory
        swordNode.physicsBody?.collisionBitMask = enemyCategory
        swordNode.physicsBody?.isDynamic = false
        swordNode.anchorPoint = CGPoint(x:SceneConstants.meleeAnchorX,y: SceneConstants.meleeAnchorY)
        
        var rotation = swordNode.zRotation
        rotation += pi / SceneConstants.swingRotation
        swordNode.zRotation = rotation
        
        
        let swing = SKAction.rotate(byAngle: -pi * SceneConstants.swingAngle, duration: SceneConstants.swingDuration)
        let deleteSword = SKAction.removeFromParent()
        
        let swingSeq = SKAction.sequence([swing, deleteSword])
        if isSwingin && GameData.shared.currentWeapon?.isMelee ?? false {
            currentPlayerNode.addChild(swordNode)
            swordNode.run(swingSeq)
        }
    }
    
    func startSwinging() {
        swingTimer = Timer.scheduledTimer(timeInterval: SceneConstants.meleeTimer, target: self, selector: #selector(swing), userInfo: nil, repeats: true)
        isStrikin = true
    }
    
    // MARK: - CAMERA
    
    func camera() {
        
        cam = SKCameraNode()
        cam.zPosition = SceneConstants.camZPosition
        cam.setScale(SceneConstants.camScale)
        
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

        if bodyB == playerCategory && bodyA == signCategory && contactA == ("Boat") {
            if GameData.shared.caveCrewMemberRescued && GameData.shared.jungleCrewMemberRescued  && GameData.shared.volcanoCrewMemberRescued && GameData.shared.collectedBoatMaterial1 && GameData.shared.collectedBoatMaterial2 && GameData.shared.collectedBoatMaterial3 {
                GameData.shared.win = true
            }
        }
        

        // MARK: - Scenes Transitions
    
        if contactA == ("CaveEntrance") && bodyB == playerCategory {
            transitionToCaveScene()
            currentPlayerNode.removeFromParent()
        }
        if contactA == ("JungleEntrance") && bodyB == playerCategory {
            transitionToJungleScene()
            currentPlayerNode.removeFromParent()
        }
        if contactA == ("VolcanoEntrance") && bodyB == playerCategory {
            transitionToVolcanoScene()
            currentPlayerNode.removeFromParent()
        }

        // MARK: - Fix this crap
        
    if bodyB == playerCategory && bodyA == skullCategory && contactA == ("Apple1") {
        contact.bodyA.node?.removeFromParent()
        GameData.shared.inventory.append(InventoryItem(name: "Apple", imageName: "Apple", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
    }
    if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Apple1") {
        contact.bodyB.node?.removeFromParent()
        GameData.shared.inventory.append(InventoryItem(name: "Apple", imageName: "Apple", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
    }
        if bodyB == playerCategory && bodyA == skullCategory && contactA == ("Watermelon1") {
            contact.bodyA.node?.removeFromParent()
            GameData.shared.inventory.append(InventoryItem(name: "Watermelon", imageName: "Watermelon", itemDescription: "Yummy red", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
        }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Watermelon1") {
            contact.bodyB.node?.removeFromParent()
            GameData.shared.inventory.append(InventoryItem(name: "Watermelon", imageName: "Watermelon", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
        }
        
    }
    
    // MARK: - UPDATES
    
    override func update(_ currentTime: TimeInterval) {
        
        // MARK: -Combat
        
        if GameData.shared.currentWeapon?.isMelee ?? false {
            if !isStrikin{
                startSwinging()
            }
        } else if GameData.shared.currentWeapon?.isRanged ?? false {
            if !isFiring {
                startShooting()
            }
        }
        
        if isMoving {
            if leftJoyconAngle >= 22.5 && leftJoyconAngle <= 67.5  { // UPRIGHT
                currentPlayerNode.position.y += SceneConstants.diagonalMove
                currentPlayerNode.position.x += SceneConstants.diagonalMove
                
                if !isAnimatingUpRightDiagonalPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .upRight, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .upRight)
                }
            } else if leftJoyconAngle >= 67.5 && leftJoyconAngle <= 112.5 { // UP
                currentPlayerNode.position.y += SceneConstants.dPadMove
                
                if !isAnimatingUpPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .up, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .up)
                }
            } else if leftJoyconAngle >= 112.5 && leftJoyconAngle <= 157.5 { // UPLEFT
                currentPlayerNode.position.y += SceneConstants.diagonalMove
                currentPlayerNode.position.x += -SceneConstants.diagonalMove
                
                if !isAnimatingUpLeftDiagonalPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .upLeft, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .upLeft)
                }
            } else if leftJoyconAngle >= 157.5 && leftJoyconAngle <= 202.5 { // LEFT
                currentPlayerNode.position.x -= SceneConstants.dPadMove
                if !isAnimatingLeftPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .left, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .left)
                }
            } else if leftJoyconAngle >= 202.5 && leftJoyconAngle <= 247.5 { // DOWNLEFT
                currentPlayerNode.position.y += -SceneConstants.diagonalMove
                currentPlayerNode.position.x += -SceneConstants.diagonalMove
                
                if !isAnimatingDownLeftDiagonalPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .downLeft, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .downLeft)
                }
            } else if leftJoyconAngle >= 247.5 && leftJoyconAngle <= 292.5 { // DOWN
                currentPlayerNode.position.y -= SceneConstants.dPadMove
                
                if !isAnimatingDownPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .down, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .down)
                }
            } else if leftJoyconAngle >= 292.5 && leftJoyconAngle <= 337.5 { // DOWNRIGHT
                currentPlayerNode.position.y += -SceneConstants.diagonalMove
                currentPlayerNode.position.x += SceneConstants.diagonalMove
                
                if !isAnimatingDownRightDiagonalPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .downRight, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .downRight)
                }
            } else if leftJoyconAngle >= 337.5 || leftJoyconAngle <= 22.5  { // RIGHT
                currentPlayerNode.position.x += SceneConstants.dPadMove
                if !isAnimatingRightPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .right, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .right)
                }
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
