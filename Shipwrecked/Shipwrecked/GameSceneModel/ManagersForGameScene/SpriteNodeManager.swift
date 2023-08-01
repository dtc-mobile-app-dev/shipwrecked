//
//  SpriteNodeManager.swift
//  Shipwrecked
//
//  Created by Asher McConnell on 8/1/23.
//

import SwiftUI
import SpriteKit

class SpriteNodeManager {
    
    static let instance = SpriteNodeManager()
    
    init() {
        
    }
    
    func createSpriteNode(spriteNode: SKSpriteNode, sceneNodeName: String, selfCategory: UInt32, collisionContactCategory: UInt32, scene: GameScene) {
        
        var spriteNoder = spriteNode
        
        spriteNoder = scene.childNode(withName: sceneNodeName) as! SKSpriteNode
        
        spriteNoder.zPosition = 10
        spriteNoder.setScale(0.5)
        spriteNoder.physicsBody = SKPhysicsBody(rectangleOf: spriteNoder.size)
        spriteNoder.physicsBody?.categoryBitMask = selfCategory
        spriteNoder.physicsBody?.collisionBitMask = collisionContactCategory
        spriteNoder.physicsBody?.contactTestBitMask = collisionContactCategory
        spriteNoder.physicsBody?.allowsRotation = false
    }
}
