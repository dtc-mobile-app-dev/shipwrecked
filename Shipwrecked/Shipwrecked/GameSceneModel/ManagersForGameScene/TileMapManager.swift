//
//  TileMapManager.swift
//  Shipwrecked
//
//  Created by Asher McConnell on 8/1/23.
//

import SwiftUI
import SpriteKit

class TileMapManager {
    
    static let instance = TileMapManager()
        
    init() {
    }
    
    func createTileMapNode(tileMapSceneName: String, selfCategory: UInt32, collisionCategory: UInt32, scene: GameScene) {

        let tileMap = scene.childNode(withName: tileMapSceneName) as! SKTileMapNode
        setUpSceneWithMap(map: tileMap, selfCategory: selfCategory, collisionCategory: collisionCategory, scene: scene)

        tileMap.removeFromParent()
    }
    
    private func setUpSceneWithMap(map: SKTileMapNode, selfCategory: UInt32, collisionCategory: UInt32, scene: GameScene) {
        
        let tileMap = map
        let startingLocation: CGPoint = tileMap.position
        let tileSize = tileMap.tileSize
        
        let halfWidth = CGFloat(tileMap.numberOfColumns) / 2 * tileSize.width
        let halfHeight = CGFloat(tileMap.numberOfRows) / 2 * tileSize.height
        
        for col in 0..<tileMap.numberOfColumns {
            
            for row in 0..<tileMap.numberOfRows {
                
                if let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row) {
                    
                    let tileArray = tileDefinition.textures
                    let tileTexture = tileArray[0]
                    let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width / 2)
                    let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height / 2)
                    
                    let tileNode = SKSpriteNode(texture: tileTexture)
                    tileNode.position = CGPoint(x: x, y: y)
                    tileNode.physicsBody = SKPhysicsBody(texture: tileTexture, size: tileTexture.size())
                    tileNode.physicsBody?.categoryBitMask = selfCategory
                    tileNode.physicsBody?.contactTestBitMask = collisionCategory
                    tileNode.physicsBody?.collisionBitMask = collisionCategory
                    tileNode.physicsBody?.isDynamic = false
                    scene.addChild(tileNode)
                    
                    tileNode.position = CGPoint(x: tileNode.position.x + startingLocation.x, y: tileNode.position.y + startingLocation.y)
                }
            }
        }
    }
}

