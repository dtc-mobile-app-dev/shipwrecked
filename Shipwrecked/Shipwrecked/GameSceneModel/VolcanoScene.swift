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


class VolcanoScene: SKScene, SKPhysicsContactDelegate, ObservableObject {
    
    // MARK: Instances
    
    @MainActor var joyconAngle = 0
    @MainActor var leftJoyconAngle: Double = 0
    var isMoving = false
    
    static var hasLoaded = false
    
    @MainActor var currentHealth = 0
    @MainActor var currentPlayer: Player?
    @MainActor var currentWeapon: Weapon?
    @MainActor var inventory = [InventoryItem(name: "Apple", imageName: "Apple", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false)]
    
    var animation = AnimationManager.instance
    var node = SpriteNodeManager.instance
    var tileMap = TileMapManager.instance
    
    // MARK: - PlayerNode
    
    var currentPlayerNode = SKSpriteNode()
    var playerHit = false
    
    var playerPosx: CGFloat = 0
    var playerPosy: CGFloat = 0
    
    // MARK: - SIGNS
    
    let volcano1Sign = SKSpriteNode()
    let volcano2Sign = SKSpriteNode()
    let volcano3Sign = SKSpriteNode()
    let volcano4Sign = SKSpriteNode()
    
    @Published var volcano1SignImage: Double = 0
    @Published var volcano2SignImage: Double = 0
    @Published var volcano3SignImage: Double = 0
    @Published var volcano4SignImage: Double = 0
    
    
    // MARK: - Pickups
    
    var boatItemPickup = SKSpriteNode()
    
    // MARK: - Food
    
        let apple1 = SKSpriteNode()
        let apple2 = SKSpriteNode()
        let apple3 = SKSpriteNode()
        let watermelon1 = SKSpriteNode()
        let watermelon2 = SKSpriteNode()
    
    // MARK: - JungleScene
    
    // Section 1
    
    let volcano1Trigger = SKSpriteNode()
    var volcano1TriggerOn = false
    
    let volcano1Enemy1 = SKSpriteNode()
    let volcano1Enemy1HealthNode = SKSpriteNode()
    
    let volcano1Enemy2 = SKSpriteNode()
    let volcano1Enemy2HealthNode = SKSpriteNode()
    
    let volcano1Enemy3 = SKSpriteNode()
    let volcano1Enemy3HealthNode = SKSpriteNode()
    
    let volcano1Enemy4 = SKSpriteNode()
    let volcano1Enemy4HealthNode = SKSpriteNode()
    
    // Section 2
    
    let volcano2Trigger = SKSpriteNode()
    var volcano2TriggerOn = false
    
    let volcano2Enemy1 = SKSpriteNode()
    let volcano2Enemy1HealthNode = SKSpriteNode()
    
    let volcano2Enemy2 = SKSpriteNode()
    let volcano2Enemy2HealthNode = SKSpriteNode()
    
    let volcano2Enemy3 = SKSpriteNode()
    let volcano2Enemy3HealthNode = SKSpriteNode()
    
    let volcano2Enemy4 = SKSpriteNode()
    let volcano2Enemy4HealthNode = SKSpriteNode()
    
    // Section 3
    
    let volcano3Trigger = SKSpriteNode()
    var volcano3TriggerOn = false
    
    let volcano3Enemy1 = SKSpriteNode()
    let volcano3Enemy1HealthNode = SKSpriteNode()
    
    let volcano3Enemy2 = SKSpriteNode()
    let volcano3Enemy2HealthNode = SKSpriteNode()
    
    let volcano3Enemy3 = SKSpriteNode()
    let volcano3Enemy3HealthNode = SKSpriteNode()
    
    let volcano3Enemy4 = SKSpriteNode()
    let volcano3Enemy4HealthNode = SKSpriteNode()
    
    // Section 4
    
    let volcano4Trigger = SKSpriteNode()
    var volcano4TriggerOn = false
    
    let volcano4Enemy1 = SKSpriteNode()
    let volcano4Enemy1HealthNode = SKSpriteNode()
    
    let volcano4Enemy2 = SKSpriteNode()
    let volcano4Enemy2HealthNode = SKSpriteNode()
    
    let volcano4Enemy3 = SKSpriteNode()
    let volcano4Enemy3HealthNode = SKSpriteNode()
    
    let volcano4Enemy4 = SKSpriteNode()
    let volcano4Enemy4HealthNode = SKSpriteNode()
    
    // Section 5
    
    let volcano5Trigger = SKSpriteNode()
    var volcano5TriggerOn = false
    
    var volcanoBoss = SKSpriteNode()
    var volcanoBossHealthBar = SKSpriteNode()
    var volcanoBoss1Projectile = SKSpriteNode()
    var volcanoBoss2Projectile = SKSpriteNode()
    var volcanoBoss3Projectile = SKSpriteNode()
    var bossFightTimer1 = Timer()
    var bossFightTimer2 = Timer()
    var bossFightTimer3 = Timer()
    var bossFightActive = false
    var isBossShooting = false
    var bossShootAngle1: Double = 1
    var bossShootAngle2: Double = 3
    var bossShootAngle3: Double = 5
    var bossTextures: [SKTexture] = []
    var ifBossAnimating = false
    var bossHealth = 6
    let healthArray = ["1BossHealth","2BossHealth","3BossHealth","4BossHealth","5BossHealth","6BossHealth","7BossHealth"]
    
    
    
    var rescueCrewMember1 = SKSpriteNode()
    var rescueCrewMember2 = SKSpriteNode()
    var rescueCrewMember3 = SKSpriteNode()
    
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
    
    // MARK: - Camera/Controller
    
    var cam: SKCameraNode!
    
    var islandEntrance = SKSpriteNode()
    var islandEntrance2 = SKSpriteNode()
    
    
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
    
    let bossCategory: UInt32 = 0x50000
    let bossProjectileCategory: UInt32 = 0x50000000
    
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        // MARK: - Tile Maps
        
        if !VolcanoScene.hasLoaded {
            
            tileMap.createTileMapNode(tileMapSceneName: "VolcanoWall", selfCategory: wallCategory, collisionCategory: playerCategory, zPosition: -1, scene: self)
            
            tileMap.createTileMapNode(tileMapSceneName: "VolcanoPath", selfCategory: pathCategory, collisionCategory: playerCategory, zPosition: 2, scene: self)
            
            // MARK: - Triggers
            
            createTrigger(withName: "Volcano1Trigger", withNode: volcano1Trigger)
            createTrigger(withName: "Volcano2Trigger", withNode: volcano2Trigger)
            createTrigger(withName: "Volcano3Trigger", withNode: volcano3Trigger)
            createTrigger(withName: "Volcano4Trigger", withNode: volcano4Trigger)
            createTrigger(withName: "Volcano5Trigger", withNode: volcano5Trigger)
            
            createTrigger(withName: "IslandEntrance", withNode: islandEntrance)
            createTrigger(withName: "IslandEntrance2", withNode: islandEntrance2)
            
            
            // MARK: - SignNodes
            
            node.createSpriteNode(spriteNode: volcano1Sign, sceneNodeName: "Volcano1Sign", selfCategory: signCategory, collisionContactCategory: playerCategory, scene: self, scale: 0.2)
            node.createSpriteNode(spriteNode: volcano2Sign, sceneNodeName: "Volcano2Sign", selfCategory: signCategory, collisionContactCategory: playerCategory, scene: self, scale: 0.2)
            node.createSpriteNode(spriteNode: volcano3Sign, sceneNodeName: "Volcano3Sign", selfCategory: signCategory, collisionContactCategory: playerCategory, scene: self, scale: 0.2)
            node.createSpriteNode(spriteNode: volcano4Sign, sceneNodeName: "Volcano4Sign", selfCategory: signCategory, collisionContactCategory: playerCategory, scene: self, scale: 0.2)
            
            node.createSpriteNode(spriteNode: captainCrew, sceneNodeName: "CaptainRescue", selfCategory: signCategory, collisionContactCategory: playerCategory, scene: self, scale: 0.6)
            
            // MARK: - ItemPickups
            
            node.createSpriteNode(spriteNode: boatItemPickup ,sceneNodeName: "WoodPlank", selfCategory: skullCategory, collisionContactCategory: playerCategory, scene: self, scale: 0.4)
            
            
            
            // MARK: - FoodPickups
            
            node.createSpriteNode(spriteNode: apple1, sceneNodeName: "Apple1", selfCategory: skullCategory, collisionContactCategory: playerCategory, scene: self, scale: 0.5)
            node.createSpriteNode(spriteNode: apple2, sceneNodeName: "Apple2", selfCategory: skullCategory, collisionContactCategory: playerCategory, scene: self, scale: 0.5)
            node.createSpriteNode(spriteNode: apple3, sceneNodeName: "Apple3", selfCategory: skullCategory, collisionContactCategory: playerCategory, scene: self, scale: 0.5)
            node.createSpriteNode(spriteNode: watermelon1, sceneNodeName: "Watermelon1", selfCategory: skullCategory, collisionContactCategory: playerCategory, scene: self, scale: 0.5)
            node.createSpriteNode(spriteNode: watermelon2, sceneNodeName: "Watermelon2", selfCategory: skullCategory, collisionContactCategory: playerCategory, scene: self, scale: 0.5)
            
            
            
            // MARK: - Characters
            
            
            
            bossEnemy()
            // MARK: - Camera/Controller
            
            camera()
            VolcanoScene.hasLoaded = true
        }
        createPlayer()
        SoundManager.instance.playMusic(sound: .VolcanoSoundtrack, volume: 0.5, loops: 5)

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
    // MARK: - Character
    
    func createPlayer() {
        
        currentPlayerNode = .init(imageNamed: GameData.shared.currentPlayer?.character ?? "nil")
        
        currentPlayerNode.position = CGPoint(x: GameData.shared.currentPlayerPositionX, y: GameData.shared.currentPlayerPositionY)
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
        
        // MARK: - Volcano Enemies
        
        "Volcano1Enemy1" : (health: 3, strength: 1),
        "Volcano1Enemy2" : (health: 3, strength: 1),
        "Volcano1Enemy3" : (health: 3, strength: 1),
        "Volcano1Enemy4" : (health: 3, strength: 1),
        
        "Volcano2Enemy1" : (health: 3, strength: 1),
        "Volcano2Enemy2" : (health: 3, strength: 1),
        "Volcano2Enemy3" : (health: 3, strength: 1),
        "Volcano2Enemy4" : (health: 3, strength: 1),
        
        "Volcano3Enemy1" : (health: 3, strength: 1),
        "Volcano3Enemy2" : (health: 3, strength: 1),
        "Volcano3Enemy3" : (health: 3, strength: 1),
        "Volcano3Enemy4" : (health: 3, strength: 1),
        
        "Volcano4Enemy1" : (health: 3, strength: 1),
        "Volcano4Enemy2" : (health: 3, strength: 1),
        "Volcano4Enemy3" : (health: 3, strength: 1),
        "Volcano4Enemy4" : (health: 3, strength: 1),
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
        gunNode = .init(imageNamed: GameData.shared.currentWeapon?.imageName ?? "nona")
        
        
        gunNode.zPosition = 4
        gunNode.setScale(0.8)
        gunNode.zRotation = CGFloat(joyconAngle.degreesToRadians)
        gunNode.physicsBody = SKPhysicsBody(rectangleOf: gunNode.size)
        gunNode.physicsBody?.affectedByGravity = false
        gunNode.physicsBody?.isDynamic = false
        gunNode.physicsBody?.categoryBitMask = pathCategory
        gunNode.physicsBody?.contactTestBitMask = enemyCategory
        gunNode.physicsBody?.collisionBitMask = enemyCategory
        gunNode.anchorPoint = CGPoint(x:-0.2,y: 0.5)
        
        let gun = SKAction.move(to: CGPoint(
            x: cos(gunNode.zRotation) + gunNode.position.x,
            y: sin(gunNode.zRotation) + gunNode.position.y)
                                ,duration: 1.0)
        let deleteGun = SKAction.removeFromParent()
        
        let gunSeq = SKAction.sequence([gun, deleteGun])
        
        bulletNode = .init(imageNamed: "CannonBall")
        
        bulletNode.name = "CannonBall"
        bulletNode.zPosition = 3
        bulletNode.position = CGPoint(x: currentPlayerNode.position.x, y: currentPlayerNode.position.y )
        bulletNode.setScale(0.1)
        bulletNode.zRotation = CGFloat(joyconAngle.degreesToRadians)
        bulletNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bulletNode.size.width / 3 , height: bulletNode.size.height * 1.6))
        bulletNode.physicsBody?.affectedByGravity = false
        bulletNode.physicsBody?.categoryBitMask = rangerCategory
        bulletNode.physicsBody?.contactTestBitMask = enemyCategory
        bulletNode.physicsBody?.collisionBitMask = enemyCategory
        bulletNode.physicsBody?.isDynamic = false
        bulletNode.anchorPoint = CGPoint(x:0.0,y: -0.15)
        
        
        let shoot = SKAction.move(to: CGPoint(
            x: 2000 * cos(bulletNode.zRotation) + bulletNode.position.x,
            y: 2000 * sin(bulletNode.zRotation) + bulletNode.position.y)
                                  ,duration: 3.0)
        let deleteBullet = SKAction.removeFromParent()
        
        let bulletSeq = SKAction.sequence([shoot, deleteBullet])
        if isShootin && GameData.shared.currentWeapon?.isRanged ?? false {
            currentPlayerNode.addChild(gunNode)
            self.addChild(bulletNode)
            bulletNode.run(bulletSeq)
            gunNode.run(gunSeq)
        }
    }
    
    func startShooting() {
        shootTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(gunFire), userInfo: nil, repeats: true)
        isFiring = true
    }
    
    @objc func swing() {
        swordNode = .init(imageNamed: GameData.shared.currentWeapon?.imageName ?? "nona")
        
        swordNode.setScale(1)
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
        if isSwingin && GameData.shared.currentWeapon?.isMelee ?? false {
            currentPlayerNode.addChild(swordNode)
            swordNode.run(swingSeq)
        }
    }
    
    func startSwinging() {
        swingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(swing), userInfo: nil, repeats: true)
        isStrikin = true
    }
    
    @objc func bossCombat1() {
        volcanoBoss1Projectile = .init(imageNamed: "fireball")
        
        volcanoBoss1Projectile.position = CGPoint(x: volcanoBoss.position.x, y: volcanoBoss.position.y )
        volcanoBoss1Projectile.setScale(0.25)
        volcanoBoss1Projectile.zPosition = 15
        volcanoBoss1Projectile.zRotation = CGFloat(bossShootAngle1)
        volcanoBoss1Projectile.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: volcanoBoss1Projectile.size.width , height: volcanoBoss1Projectile.size.height ))
        volcanoBoss1Projectile.physicsBody?.affectedByGravity = false
        volcanoBoss1Projectile.physicsBody?.categoryBitMask = bossProjectileCategory
        volcanoBoss1Projectile.physicsBody?.contactTestBitMask = playerCategory
        volcanoBoss1Projectile.physicsBody?.collisionBitMask = playerCategory
        volcanoBoss1Projectile.physicsBody?.isDynamic = false
        
        let shoot = SKAction.move(to: CGPoint(
            x: 2000 * cos(volcanoBoss1Projectile.zRotation) + volcanoBoss1Projectile.position.x,
            y: 2000 * sin(volcanoBoss1Projectile.zRotation) + volcanoBoss1Projectile.position.y)
                                  ,duration: 5.0)
        let deleteBullet = SKAction.removeFromParent()
        
        let bossSeq = SKAction.sequence([shoot, deleteBullet])
        if isBossShooting {
            self.addChild(volcanoBoss1Projectile)
            volcanoBoss1Projectile.run(bossSeq)
        }
        
    }
    
    func volcanoBossFightActivate1() {
        bossFightTimer1 = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(bossCombat1), userInfo: nil, repeats: true)
        bossFightActive = true
    }
    
    @objc func bossCombat2() {
        volcanoBoss2Projectile = .init(imageNamed: "fireball")
        
        volcanoBoss2Projectile.position = CGPoint(x: volcanoBoss.position.x, y: volcanoBoss.position.y )
        volcanoBoss2Projectile.setScale(0.25)
        volcanoBoss2Projectile.zPosition = 15
        volcanoBoss2Projectile.zRotation = CGFloat(bossShootAngle2)
        volcanoBoss2Projectile.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: volcanoBoss2Projectile.size.width , height: volcanoBoss2Projectile.size.height ))
        volcanoBoss2Projectile.physicsBody?.affectedByGravity = false
        volcanoBoss2Projectile.physicsBody?.categoryBitMask = bossProjectileCategory
        volcanoBoss2Projectile.physicsBody?.contactTestBitMask = playerCategory
        volcanoBoss2Projectile.physicsBody?.collisionBitMask = playerCategory
        volcanoBoss2Projectile.physicsBody?.isDynamic = false
        
        let shoot = SKAction.move(to: CGPoint(
            x: 2000 * cos(volcanoBoss2Projectile.zRotation) + volcanoBoss2Projectile.position.x,
            y: 2000 * sin(volcanoBoss2Projectile.zRotation) + volcanoBoss2Projectile.position.y)
                                  ,duration: 5.0)
        let deleteBullet = SKAction.removeFromParent()
        
        let bossSeq = SKAction.sequence([shoot, deleteBullet])
        if isBossShooting {
            self.addChild(volcanoBoss2Projectile)
            volcanoBoss2Projectile.run(bossSeq)
        }
        
    }
    
    func volcanoBossFightActivate2() {
        bossFightTimer2 = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(bossCombat2), userInfo: nil, repeats: true)
        bossFightActive = true
    }
    
    @objc func bossCombat3() {
        volcanoBoss3Projectile = .init(imageNamed: "fireball")
        
        volcanoBoss3Projectile.position = CGPoint(x: volcanoBoss.position.x, y: volcanoBoss.position.y )
        volcanoBoss3Projectile.setScale(0.8)
        volcanoBoss3Projectile.zPosition = 15
        volcanoBoss3Projectile.zRotation = CGFloat(bossShootAngle3)
        volcanoBoss3Projectile.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: volcanoBoss3Projectile.size.width , height: volcanoBoss3Projectile.size.height ))
        volcanoBoss3Projectile.physicsBody?.affectedByGravity = false
        volcanoBoss3Projectile.physicsBody?.categoryBitMask = bossProjectileCategory
        volcanoBoss3Projectile.physicsBody?.contactTestBitMask = playerCategory
        volcanoBoss3Projectile.physicsBody?.collisionBitMask = playerCategory
        volcanoBoss3Projectile.physicsBody?.isDynamic = false
        
        let shoot = SKAction.move(to: CGPoint(
            x: 2000 * cos(volcanoBoss3Projectile.zRotation) + volcanoBoss3Projectile.position.x,
            y: 2000 * sin(volcanoBoss3Projectile.zRotation) + volcanoBoss3Projectile.position.y)
                                  ,duration: 4.0)
        let deleteBullet = SKAction.removeFromParent()
        
        let bossSeq = SKAction.sequence([shoot, deleteBullet])
        if isBossShooting {
            self.addChild(volcanoBoss3Projectile)
            volcanoBoss3Projectile.run(bossSeq)
        }
        
    }
    
    func volcanoBossFightActivate3() {
        bossFightTimer3 = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(bossCombat3), userInfo: nil, repeats: true)
        bossFightActive = true
    }
    
    // MARK: - ENEMY Creation
    
    func bossEnemy() {
        
        volcanoBoss = self.childNode(withName: "VolcanoBoss") as! SKSpriteNode
                

        volcanoBoss.zPosition = 5
        volcanoBoss.setScale(1)
        volcanoBoss.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: volcanoBoss.size.width / 2 , height: volcanoBoss.size.height / 2) )
        volcanoBoss.physicsBody?.categoryBitMask = bossCategory
        volcanoBoss.physicsBody?.collisionBitMask = rangerCategory | meleeCategory | playerCategory
        volcanoBoss.physicsBody?.contactTestBitMask = rangerCategory | meleeCategory | playerCategory
        volcanoBoss.physicsBody?.allowsRotation = false
        volcanoBoss.physicsBody?.isDynamic = true
    }
    
    func bossHealthBar() {
        volcanoBossHealthBar = self.childNode(withName: "BossHealthBar") as! SKSpriteNode
        
        volcanoBossHealthBar.texture = SKTexture(imageNamed: healthArray[bossHealth])
        volcanoBossHealthBar.position = CGPoint(x: volcanoBoss.position.x, y: volcanoBoss.position.y + 200 )
        volcanoBossHealthBar.setScale(1.5)
        volcanoBossHealthBar.zPosition = 6
    }
    
    func bossAnimate() {
        
        bossTextures.append(SKTexture(imageNamed: "LavaMonster1"))
        bossTextures.append(SKTexture(imageNamed: "LavaMonster2"))
        bossTextures.append(SKTexture(imageNamed: "LavaMonster3"))
        bossTextures.append(SKTexture(imageNamed: "LavaMonster4"))
        bossTextures.append(SKTexture(imageNamed: "LavaMonster5"))
        bossTextures.append(SKTexture(imageNamed: "LavaMonster6"))
        bossTextures.append(SKTexture(imageNamed: "LavaMonster7"))
        bossTextures.append(SKTexture(imageNamed: "LavaMonster8"))
        bossTextures.append(SKTexture(imageNamed: "LavaMonster9"))
        bossTextures.append(SKTexture(imageNamed: "LavaMonster10"))
        
       
        
        let animation = SKAction.animate(with: bossTextures, timePerFrame: 0.1)
        let animateRepeat = SKAction.repeatForever(animation)
        
        volcanoBoss.run(animateRepeat)
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
                let chaseSpeed: CGFloat = -2
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
    
    func rescueMove(animationName: String, node: SKSpriteNode, sceneName: String, ifRescued: Bool, posX: CGFloat, posY: CGFloat) {
        
        var rescueNode = node
        
        rescueNode = self.childNode(withName: sceneName) as! SKSpriteNode
        
        
        rescueNode.zPosition = 5
        rescueNode.setScale(0.4)
        rescueNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rescueNode.size.width / 2 , height: rescueNode.size.height) )
        rescueNode.physicsBody?.categoryBitMask = signCategory
        rescueNode.physicsBody?.collisionBitMask = wallCategory | playerCategory | enemyCategory
        rescueNode.physicsBody?.contactTestBitMask = wallCategory | playerCategory | enemyCategory
        rescueNode.physicsBody?.allowsRotation = false
        
        if ifRescued {
            rescueNode.position = CGPoint(x: posX, y: posY)
            let differenceX = rescueNode.position.x - currentPlayerNode.position.x
            let differenceY = rescueNode.position.y - currentPlayerNode.position.y
            let angle = atan2(differenceY, differenceX)
            let chaseSpeed: CGFloat = -4
            let vx = chaseSpeed * cos(angle)
            let vy = chaseSpeed * sin(angle)
            
            let pi = Double.pi
            
            var angle2 = angle + 7 * pi/8
            
            if angle2 < 0 {
                angle2 = angle2 + 2 * pi
            }
            
            if angle2 < pi/4 { // UPRIGHT
                if !isAnimatingUpRightDiagonalEnemy {
                    animation.animate(character: animationName, direction: .upRight, characterNode: rescueNode)
                    setAnimateBoolsEnemy(direction: .upRight)
                }
            } else if angle2 < pi/2 { // UP
                if !isAnimatingUpEnemy {
                    animation.animate(character: animationName, direction: .up, characterNode: rescueNode)
                    setAnimateBoolsEnemy(direction: .up)
                }
            } else if angle2 < 3 * pi/4 { // UPLEFT
                if !isAnimatingUpLeftDiagonalEnemy {
                    animation.animate(character: animationName, direction: .upLeft, characterNode: rescueNode)
                    setAnimateBoolsEnemy(direction: .upLeft)
                }
            } else if angle2 < pi { // LEFT
                if !isAnimatingLeftEnemy {
                    animation.animate(character: animationName, direction: .left, characterNode: rescueNode)
                    setAnimateBoolsEnemy(direction: .left)
                }
            } else if angle2 < 5 * pi/4 { // DOWNLEFT
                if !isAnimatingDownLeftDiagonalEnemy {
                    animation.animate(character: animationName, direction: .downLeft, characterNode: rescueNode)
                    setAnimateBoolsEnemy(direction: .downLeft)
                }
            } else if angle2 < 3 * pi/2 { // DOWN
                if !isAnimatingDownEnemy {
                    animation.animate(character: animationName, direction: .down, characterNode: rescueNode)
                    setAnimateBoolsEnemy(direction: .down)
                }
            } else if angle2 < 7 * pi/4 { // DOWNRIGHT
                if !isAnimatingDownRightDiagonalEnemy {
                    animation.animate(character: animationName, direction: .downRight, characterNode: rescueNode)
                    setAnimateBoolsEnemy(direction: .downRight)
                }
            } else { // RIGHT
                if !isAnimatingRightEnemy {
                    animation.animate(character: animationName, direction: .right, characterNode: rescueNode)
                    setAnimateBoolsEnemy(direction: .right)
                }
            }
            
            rescueNode.position.x += vx
            rescueNode.position.y += vy
        }
    }
    
    // MARK: - Combat Contacts
    
    func contactedEnemyMelee(enemyNode: SKNode, contactName: String) {
        if !meleeCombatBool {
            SoundManager.instance.playTikiSound(sound: .EnemyHitSound, volume: 5.0)
            enemyDictionary[contactName]?.health -= 1
            meleeCombatBool = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
                meleeCombatBool = false
            }
        }
        
        if enemyDictionary[contactName]!.health < 1 {
            enemyNode.removeAllActions()
            enemyNode.removeFromParent()
        }
    }
    
    func contactedEnemyRanger(enemyNode: SKNode, contactName: String) {
        if !rangerCombatBool {
            SoundManager.instance.playTikiSound(sound: .EnemyHitSound, volume: 5.0)
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
    
    func contactedBossRanger() {
        if !rangerCombatBool {
            SoundManager.instance.playBossSound(sound: .LavaBossHitSound, volume: 5.0)
            bossHealth -= 1
            rangerCombatBool = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
                rangerCombatBool = false
            }
        }
        if bossHealth < 0 {
            volcanoBoss.removeAllActions()
            volcanoBoss.removeFromParent()
            volcanoBossHealthBar.removeFromParent()

        }
        
    }
    func contactedBossMelee() {
        
        if !meleeCombatBool {
            bossHealth -= 1
            SoundManager.instance.playBossSound(sound: .LavaBossHitSound, volume: 5.0)
            meleeCombatBool = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
                meleeCombatBool = false
            }
        }
        if bossHealth < 1 {
            volcanoBoss.removeAllActions()
            volcanoBoss.removeFromParent()
            volcanoBossHealthBar.removeFromParent()
            
        }
    }
    
    func contactedRip(graveNode: SKNode, enemyKey: String) {
        if enemyDictionary[enemyKey]!.health == 0  {
            enemyDictionary[enemyKey]?.health -= 1
            graveNode.removeAllActions()
            graveNode.removeFromParent()
        }
    }
    func playerHitFunc() {
        if !playerHit && GameData.shared.currentHealth > 0 {
            SoundManager.instance.playerSound(sound: .PlayerHitSound, volume: 5.0)
            GameData.shared.currentHealth -= 1
            playerHit = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                playerHit = false
            }
        } else if GameData.shared.currentHealth <= 0 {
            GameData.shared.deathCounter += 1
            GameData.shared.currentPlayerPositionX = -1700
            GameData.shared.currentPlayerPositionY = 1300
            GameData.shared.currentHealth = 6
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
    
    func transitionToIslandScene() {
        currentPlayerNode.removeFromParent()
        GameData.shared.currentLevel = .scene
        GameData.shared.currentPlayerPositionX = 1100
        GameData.shared.currentPlayerPositionY = -1200
    }
    
    // MARK: - PHYSICS INTERACTION
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactA = contact.bodyA.node?.name
        let contactB = contact.bodyB.node?.name
        
        let bodyA = contact.bodyA.node?.physicsBody?.categoryBitMask
        let bodyB = contact.bodyB.node?.physicsBody?.categoryBitMask
        
        print("Contact A\(bodyA) Contact B \(contactB)")
        
        // MARK: - Enemy Health Contact
        
        if bodyA == enemyCategory && bodyB == meleeCategory {
            contactedEnemyMelee(enemyNode: contact.bodyA.node ?? SKNode(), contactName: contactA ?? "nil")
        }
        if bodyB == enemyCategory && bodyA == meleeCategory {
            contactedEnemyMelee(enemyNode: contact.bodyB.node ?? SKNode(), contactName: contactB ?? "nil")
        }
        
        if contactA == ("IslandEntrance") && bodyB == playerCategory {
            transitionToIslandScene()
        }
        if contactA == ("IslandEntrance2") && bodyB == playerCategory {
            transitionToIslandScene()
        }
        if contactB == ("IslandEntrance2") && bodyA == playerCategory {
            transitionToIslandScene()
        }
        
        if bodyB == playerCategory && bodyA == skullCategory && contactA == ("WoodPlank") {
            GameData.shared.collectedBoatMaterial1 = true
            contact.bodyA.node?.removeFromParent()
        }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("WoodPlank") {
            GameData.shared.collectedBoatMaterial1 = true
            contact.bodyB.node?.removeFromParent()
        }
        
        if bodyB == playerCategory && bodyA == skullCategory && contactA == ("Apple1") {
            contact.bodyA.node?.removeFromParent()
            GameData.shared.inventory.append(InventoryItem(name: "Apple", imageName: "Apple", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
        }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Apple1") {
            contact.bodyB.node?.removeFromParent()
            GameData.shared.inventory.append(InventoryItem(name: "Apple", imageName: "Apple", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
        }
        if bodyB == playerCategory && bodyA == skullCategory && contactA == ("Apple2") {
            contact.bodyA.node?.removeFromParent()
            GameData.shared.inventory.append(InventoryItem(name: "Apple", imageName: "Apple", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
        }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Apple2") {
            contact.bodyB.node?.removeFromParent()
            GameData.shared.inventory.append(InventoryItem(name: "Apple", imageName: "Apple", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
        }
        if bodyB == playerCategory && bodyA == skullCategory && contactA == ("Apple3") {
            contact.bodyA.node?.removeFromParent()
            GameData.shared.inventory.append(InventoryItem(name: "Apple", imageName: "Apple", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
        }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Apple3") {
            contact.bodyB.node?.removeFromParent()
            GameData.shared.inventory.append(InventoryItem(name: "Apple", imageName: "Apple", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
        }
        if bodyB == playerCategory && bodyA == skullCategory && contactA == ("Watermelon1") {
            contact.bodyA.node?.removeFromParent()
            GameData.shared.inventory.append(InventoryItem(name: "Watermelon", imageName: "Watermelon", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
        }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Watermelon1") {
            contact.bodyB.node?.removeFromParent()
            GameData.shared.inventory.append(InventoryItem(name: "Watermelon", imageName: "Watermelon", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
        }
        if bodyB == playerCategory && bodyA == skullCategory && contactA == ("Watermelon2") {
            contact.bodyA.node?.removeFromParent()
            GameData.shared.inventory.append(InventoryItem(name: "Watermelon", imageName: "Watermelon", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
        }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Watermelon2") {
            contact.bodyB.node?.removeFromParent()
            GameData.shared.inventory.append(InventoryItem(name: "Watermelon", imageName: "Watermelon", itemDescription: "Yummy green", isWeapon: false, isFood: true, isRanged: false, isMelee: false))
        }
        
        // MARK: - Gunner Rescue
        
        if bodyB == playerCategory && bodyA == signCategory && contactA == ("CaptainRescue") {
            GameData.shared.volcanoCrewMemberRescued = true
            contact.bodyA.node?.removeFromParent()
        }
        if bodyA == playerCategory && bodyB == signCategory && contactB == ("CaptainRescue") {
            GameData.shared.volcanoCrewMemberRescued = true
            contact.bodyB.node?.removeFromParent()
        }
        
        
        if bodyA == enemyCategory && bodyB == rangerCategory {
            contactedEnemyRanger(enemyNode: contact.bodyA.node ?? SKNode(), contactName: contactA ?? "nil")
            contact.bodyB.node?.removeFromParent()
        }
        if bodyB == enemyCategory && bodyA == rangerCategory {
            contactedEnemyRanger(enemyNode: contact.bodyB.node ?? SKNode(), contactName: contactB ?? "nil")
            contact.bodyA.node?.removeFromParent()
        }
        
        if bodyA == bossCategory && bodyB == rangerCategory {
            contactedBossRanger()
            contact.bodyB.node?.removeFromParent()
        }
        if bodyB == bossCategory && bodyA == rangerCategory {
            contactedBossRanger()
            contact.bodyA.node?.removeFromParent()
        }
        
        // MARK: - Player Health
        
        if bodyA == playerCategory && bodyB == enemyCategory || bodyB == bossProjectileCategory {
            playerHitFunc()
        }
        if bodyB == playerCategory && bodyA == enemyCategory || bodyA == bossProjectileCategory {
            playerHitFunc()
        }
        
        if bodyA == playerCategory && bodyB == bossProjectileCategory {
            contact.bodyB.node?.removeFromParent()
        }
        if bodyB == playerCategory && bodyA == bossProjectileCategory {
            contact.bodyA.node?.removeFromParent()
        }
    
        
        // MARK: - VOLCANO TRIGGERS
        
        if contactA == ("Volcano1Trigger") && bodyB == playerCategory {
            volcano1TriggerOn = true
        }
        if contactA == ("Volcano2Trigger") && bodyB == playerCategory {
            volcano2TriggerOn = true
        }
        if contactA == ("Volcano3Trigger") && bodyB == playerCategory {
            volcano3TriggerOn = true
        }
        if contactA == ("Volcano4Trigger") && bodyB == playerCategory {
            volcano4TriggerOn = true
        }
        if contactA == ("Volcano5Trigger") && bodyB == playerCategory {
            volcano5TriggerOn = true
        }
        
        // MARK: - VOLCANO SIGNS
        
        if bodyA == playerCategory && bodyB == signCategory && contactB == ("Volcano1Sign") {
            volcano1SignImage = 1
        }
        if bodyA == playerCategory && bodyB == signCategory && contactB == ("Volcano2Sign") {
            volcano2SignImage = 1
        }
        if bodyA == playerCategory && bodyB == signCategory && contactB == ("Volcano3Sign") {
            volcano3SignImage = 1
        }
        if bodyA == playerCategory && bodyB == signCategory && contactB == ("Volcano4Sign") {
            volcano4SignImage = 1
        }
        
        if bodyB == playerCategory && bodyA == signCategory && contactA == ("Volcano1Sign") {
            volcano1SignImage = 1
        }
        if bodyB == playerCategory && bodyA == signCategory && contactA == ("Volcano2Sign") {
            volcano2SignImage = 1
        }
        if bodyB == playerCategory && bodyA == signCategory && contactA == ("Volcano3Sign") {
            volcano3SignImage = 1
        }
        if bodyB == playerCategory && bodyA == signCategory && contactA == ("Volcano4Sign") {
            volcano4SignImage = 1
        }
        
        if bodyB == playerCategory && bodyA == pathCategory {
            volcano1SignImage = 0
            volcano2SignImage = 0
            volcano3SignImage = 0
            volcano4SignImage = 0
            
        }
        
        //MARK: - VOLCANO GRAVES SECTION 1
        
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano1Enemy1HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano1Enemy1") }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano1Enemy2HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano1Enemy2") }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano1Enemy3HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano1Enemy3") }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano1Enemy4HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano1Enemy4") }
        
        //MARK: - VOLCANO GRAVES SECTION 2
        
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano2Enemy1HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano2Enemy1") }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano2Enemy2HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano2Enemy2") }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano2Enemy3HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano2Enemy3") }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano2Enemy4HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano2Enemy4") }
        
        //MARK: - VOLCANO GRAVES SECTION 3
        
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano3Enemy1HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano3Enemy1") }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano3Enemy2HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano3Enemy2") }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano3Enemy3HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano3Enemy3") }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano3Enemy4HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano3Enemy4") }
        
        //MARK: - VOLCANO GRAVES SECTION 4
        
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano4Enemy1HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano4Enemy1") }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano4Enemy2HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano4Enemy2") }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano4Enemy3HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano4Enemy3") }
        if bodyA == playerCategory && bodyB == skullCategory && contactB == ("Volcano4Enemy4HealthBar") { contactedRip(graveNode: contact.bodyB.node ?? SKNode(), enemyKey: "Volcano4Enemy4") }
    }
    
    // MARK: - UPDATES
    
    override func update(_ currentTime: TimeInterval) {
        
        print("\(joyconAngle)")
        
        // MARK: -Combat
        if GameData.shared.currentWeapon?.isMelee ?? false {
            if !isStrikin{
                startSwinging()
            }
        }
        if GameData.shared.currentWeapon?.isRanged ?? false {
            if !isFiring {
                startShooting()
            }
        }
        
        bossShootAngle1 += 7
        bossShootAngle2 += 7
        bossShootAngle3 += 7
        
                // MARK: - VolcanoEnemyActivate
            
            if volcano1TriggerOn {
                enemyMove(enemyName: "redWarrior", node: volcano1Enemy1, enemySceneName: "volcano1Enemy1", healthBarNode: volcano1Enemy1HealthNode)
                enemyMove(enemyName: "redWarrior", node: volcano1Enemy2, enemySceneName: "Volcano1Enemy2", healthBarNode: volcano1Enemy2HealthNode)
                enemyMove(enemyName: "redWarrior", node: volcano1Enemy3, enemySceneName: "Volcano1Enemy3", healthBarNode: volcano1Enemy3HealthNode)
                enemyMove(enemyName: "redWarrior", node: volcano1Enemy4, enemySceneName: "Volcano1Enemy4", healthBarNode: volcano1Enemy4HealthNode)
            }
            if volcano2TriggerOn {
                enemyMove(enemyName: "redWarrior", node: volcano2Enemy1, enemySceneName: "Volcano2Enemy1", healthBarNode: volcano2Enemy1HealthNode)
                enemyMove(enemyName: "redWarrior", node: volcano2Enemy2, enemySceneName: "Volcano2Enemy2", healthBarNode: volcano2Enemy2HealthNode)
                enemyMove(enemyName: "redWarrior", node: volcano2Enemy3, enemySceneName: "Volcano2Enemy3", healthBarNode: volcano2Enemy3HealthNode)
                enemyMove(enemyName: "redWarrior", node: volcano2Enemy4, enemySceneName: "Volcano2Enemy4", healthBarNode: volcano2Enemy4HealthNode)
            }
            if volcano3TriggerOn {
                enemyMove(enemyName: "redWarrior", node: volcano3Enemy1, enemySceneName: "Volcano3Enemy1", healthBarNode: volcano3Enemy1HealthNode)
                enemyMove(enemyName: "redWarrior", node: volcano3Enemy2, enemySceneName: "Volcano3Enemy2", healthBarNode: volcano3Enemy2HealthNode)
                enemyMove(enemyName: "redWarrior", node: volcano3Enemy3, enemySceneName: "Volcano3Enemy3", healthBarNode: volcano3Enemy3HealthNode)
                enemyMove(enemyName: "redWarrior", node: volcano3Enemy4, enemySceneName: "Volcano3Enemy4", healthBarNode: volcano3Enemy4HealthNode)
            }
            if volcano4TriggerOn {
                enemyMove(enemyName: "redWarrior", node: volcano4Enemy1, enemySceneName: "Volcano4Enemy1", healthBarNode: volcano4Enemy1HealthNode)
                enemyMove(enemyName: "redWarrior", node: volcano4Enemy2, enemySceneName: "Volcano4Enemy2", healthBarNode: volcano4Enemy2HealthNode)
                enemyMove(enemyName: "redWarrior", node: volcano4Enemy3, enemySceneName: "Volcano4Enemy3", healthBarNode: volcano4Enemy3HealthNode)
                enemyMove(enemyName: "redWarrior", node: volcano4Enemy4, enemySceneName: "Volcano4Enemy4", healthBarNode: volcano4Enemy4HealthNode)
            }
        if volcano5TriggerOn {
            isBossShooting = true
            if bossHealth >= 0 {
                bossHealthBar()
                if !bossFightActive {
                    if !ifBossAnimating {
                        SoundManager.instance.playMusic(sound: .VolcanoBoss, volume: 0.3, loops: 5)
                        bossAnimate()
                        ifBossAnimating = true
                    }
                    volcanoBossFightActivate1()
                    volcanoBossFightActivate2()
                    volcanoBossFightActivate3()
                }
            } else {
                bossFightTimer1.invalidate()
                bossFightTimer2.invalidate()
                bossFightTimer3.invalidate()
                volcano5TriggerOn = false
                SoundManager.instance.playMusic(sound: .VolcanoSoundtrack, volume: 0.3, loops: 5)
            }
        }
        
    
        
        if isMoving {
            if leftJoyconAngle >= 22.5 && leftJoyconAngle <= 67.5  { // UPRIGHT
                currentPlayerNode.position.y += 2.8
                currentPlayerNode.position.x += 2.8
                
                if !isAnimatingUpRightDiagonalPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .upRight, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .upRight)
                }
            } else if leftJoyconAngle >= 67.5 && leftJoyconAngle <= 112.5 { // UP
                currentPlayerNode.position.y += 5
                
                if !isAnimatingUpPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .up, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .up)
                }
            } else if leftJoyconAngle >= 112.5 && leftJoyconAngle <= 157.5 { // UPLEFT
                currentPlayerNode.position.y += 2.8
                currentPlayerNode.position.x += -2.8
                
                if !isAnimatingUpLeftDiagonalPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .upLeft, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .upLeft)
                }
            } else if leftJoyconAngle >= 157.5 && leftJoyconAngle <= 202.5 { // LEFT
                currentPlayerNode.position.x -= 5
                if !isAnimatingLeftPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .left, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .left)
                }
            } else if leftJoyconAngle >= 202.5 && leftJoyconAngle <= 247.5 { // DOWNLEFT
                currentPlayerNode.position.y += -2.8
                currentPlayerNode.position.x += -2.8
                
                if !isAnimatingDownLeftDiagonalPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .downLeft, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .downLeft)
                }
            } else if leftJoyconAngle >= 247.5 && leftJoyconAngle <= 292.5 { // DOWN
                currentPlayerNode.position.y -= 5
                
                if !isAnimatingDownPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .down, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .down)
                }
            } else if leftJoyconAngle >= 292.5 && leftJoyconAngle <= 337.5 { // DOWNRIGHT
                currentPlayerNode.position.y += -2.8
                currentPlayerNode.position.x += 2.8
                
                if !isAnimatingDownRightDiagonalPlayer {
                    animation.animate(character: GameData.shared.currentPlayer?.weapon ?? "nil", direction: .downRight, characterNode: currentPlayerNode)
                    setAnimateBoolsPlayer(direction: .downRight)
                }
            } else if leftJoyconAngle >= 337.5 || leftJoyconAngle <= 22.5  { // RIGHT
                currentPlayerNode.position.x += 5
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
        
//        if GameData.shared.caveCrewMemberRescued {
//            rescueMove(animationName: "gunner", node: gunnerCrew, sceneName: "GunnerRescue", ifRescued: GameData.shared.caveCrewMemberRescued, posX: GameData.shared.gunnerPlayerPositionX, posY: GameData.shared.gunnerPlayerPositionY)
//        }
//
//            rescueMove(animationName: "captain", node: gunnerCrew, sceneName: "CaptainRescue", ifRescued: GameData.shared.volcanoCrewMemberRescued, posX: GameData.shared.captainPlayerPositionX, posY: GameData.shared.captainPlayerPositionY)
//
//        if GameData.shared.jungleCrewMemberRescued {
//            rescueMove(animationName: "kevin", node: gunnerCrew, sceneName: "KevinRescue", ifRescued: GameData.shared.jungleCrewMemberRescued, posX: GameData.shared.kevinPlayerPositionX, posY: GameData.shared.kevinPlayerPositionY)
//        }
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



