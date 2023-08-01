//
//  AnimationManager.swift
//  Shipwrecked
//
//  Created by Asher McConnell on 8/1/23.
//

import SwiftUI
import SpriteKit

class AnimationManager {
    
    enum Direction {
        case up
        case down
        case left
        case right
        case upRight
        case upLeft
        case downRight
        case downLeft
    }
    
    static let instance = AnimationManager() // Singleton
    
    init() {
        
    }
    
    let characterImages: [String : (leftImages: [String], rightImages: [String], downImages: [String], upImages: [String], upLeftImages: [String], upRightImages: [String], downLeftImages: [String], downRightImages: [String])] = [
        
        "captain" : (
            leftImages: ["CapLeft1", "CapLeft2", "CapLeft3", "CapLeft4"],
            rightImages: ["CapRight1", "CapRight2", "CapRight3", "CapRight4"],
            downImages: ["CapDwn1", "CapDwn2", "CapDwn3", "CapDwn4"],
            upImages: ["CapUp1", "CapUp2", "CapUp3", "CapUp4"],
            upLeftImages: ["CapDiagUpLeft1", "CapDiagUpLeft2", "CapDiagUpLeft3", "CapDiagUpLeft4"],
            upRightImages: ["CapDiagUpRight1", "CapDiagUpRight2", "CapDiagUpRight3", "CapDiagUpRight4"],
            downLeftImages: ["CapDiagDwnLeft1", "CapDiagDwnLeft2", "CapDiagDwnLeft3", "CapDiagDwnLeft4"],
            downRightImages: ["CapDiagDwnRight1", "CapDiagDwnRight2", "CapDiagDwnRight3", "CapDiagDwnRight4"])
    ]
    
    
    func animate(character: String, direction: Direction, characterNode: SKSpriteNode) {
        
        var texture: [SKTexture] = []
        var directionImages: [String]?
        
        switch direction {
        case .up : directionImages = characterImages[character]?.upImages
        case .down: directionImages = characterImages[character]?.downImages
        case .left: directionImages = characterImages[character]?.leftImages
        case .right: directionImages = characterImages[character]?.rightImages
        case .upLeft: directionImages = characterImages[character]?.upLeftImages
        case .upRight: directionImages = characterImages[character]?.upRightImages
        case .downLeft: directionImages = characterImages[character]?.downLeftImages
        case .downRight: directionImages = characterImages[character]?.downRightImages
        }
        
        texture.append(SKTexture(imageNamed: directionImages![0]))
        texture.append(SKTexture(imageNamed: directionImages![1]))
        texture.append(SKTexture(imageNamed: directionImages![2]))
        texture.append(SKTexture(imageNamed: directionImages![3]))
        
        let animation = SKAction.animate(with: texture, timePerFrame: 0.2)
        let animateRepeat = SKAction.repeatForever(animation)
        
        characterNode.run(animateRepeat)
    }
}

