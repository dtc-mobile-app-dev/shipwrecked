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
                    upLeftImages: ["DiagonalUpLeft1", "DiagonalUpLeft2", "DiagonalUpLeft3", "DiagonalUpLeft4"],
                    upRightImages: ["CapDiagUpRight1", "CapDiagUpRight2", "CapDiagUpRight3", "CapDiagUpRight4"],
                    downLeftImages: ["CapDiagDwnLeft1", "CapDiagDwnLeft2", "CapDiagDwnLeft3", "CapDiagDwnLeft4"],
                    downRightImages: ["CapDiagDwnRight1", "CapDiagDwnRight2", "CapDiagDwnRight3", "CapDiagDwnRight4"]),
        
        "gunner" : (
            
                    leftImages: ["GunnerLeft1", "GunnerLeft2", "GunnerLeft3", "GunnerLeft4"],
                    rightImages: ["GunnerRight1", "GunnerRight2", "GunnerRight3", "GunnerRight4"],
                    downImages: ["GunnerDwn1", "GunnerDwn2", "GunnerDwn3", "GunnerDwn4"],
                    upImages: ["GunnerUp1", "GunnerUp2", "GunnerUp3", "GunnerUp4"],
                    upLeftImages: ["GunnerDiagUpLeft1", "GunnerDiagUpLeft2", "GunnerDiagUpLeft3", "GunnerDiagUpLeft4"],
                    upRightImages: ["GunnerDiagUpRight1", "GunnerDiagUpRight2", "GunnerDiagUpRight3", "GunnerDiagUpRight4"],
                    downLeftImages: ["GunnerDiagDwnLeft1", "GunnerDiagDwnLeft2", "GunnerDiagDwnLeft3", "GunnerDiagDwnLeft4"],
                    downRightImages: ["GunnerDiagDwnRight1", "GunnerDiagDwnRight2", "GunnerDiagDwnRight3", "GunnerDiagDwnRight4"]),
        "welder" : (
                
                    leftImages: ["WelderLeft1", "WelderLeft2", "WelderLeft3", "WelderLeft4"],
                    rightImages: ["WelderRight1", "WelderRight2", "WelderRight3", "WelderRight4"],
                    downImages: ["WelderDwn1", "GunnerDwn2", "GunnerDwn3", "GunnerDwn4"],
                    upImages: ["WelderUp1", "WelderUp2", "WelderUp3", "WelderUp4"],
                    upLeftImages: ["WelderDiagUpLeft1", "WelderDiagUpLeft2", "WelderDiagUpLeft3", "WelderDiagUpLeft4"],
                    upRightImages: ["WelderDiagUpRight1", "WelderDiagUpRight2", "WelderDiagUpRight3", "WelderDiagUpRight4"],
                    downLeftImages: ["DiagonalDownLeft1", "DiagonalDownLeft2", "DiagonalDownLeft3", "DiagonalDownLeft4"],
                    downRightImages: ["DiagonalDownRight1", "DiagonalDownRight2", "DiagonalDownRight3", "DiagonalDownRight4"]),
        "kevin" : (
                    leftImages: ["KevinLeft1", "KevinLeft2", "KevinLeft3", "KevinLeft4"],
                    rightImages: ["KevinRight1", "KevinRight2", "KevinRight3", "KevinRight4"],
                    downImages: ["KevinDwn1", "KevinDwn2", "KevinDwn3", "KevinDwn4"],
                    upImages: ["KevinUp1", "KevinUp2", "KevinUp3", "KevinUp4"],
                    upLeftImages: ["KevinDiagUpLeft1", "KevinDiagUpLeft2", "KevinDiagUpLeft3", "KevinDiagUpLeft4"],
                    upRightImages: ["KevinDiagUpRight1", "KevinDiagUpRight2", "KevinDiagUpRight3", "KevinDiagUpRight4"],
                    downLeftImages: ["KevinDiagDwnLeft1", "KevinDiagDwnLeft2", "KevinDiagDwnLeft3", "KevinDiagDwnLeft4"],
                    downRightImages: ["KevinDiagDwnRight1", "KevinDiagDwnRight2", "KevinDiagDwnRight3", "KevinDiagDwnRight4"]),
        "redWarrior" : (
                    leftImages: ["RedWarLeft1", "RedWarLeft2", "RedWarLeft3", "RedWarLeft4"],
                    rightImages: ["RedWarRight1", "RedWarRight2", "RedWarRight3", "RedWarRight4"],
                    downImages: ["RedWarDwn1", "RedWarDwn2", "RedWarDwn3", "RedWarDwn4"],
                    upImages: ["RedWarUp1", "RedWarUp2", "RedWarUp3", "RedWarUp4"],
                    upLeftImages: ["RedWarDiagUpLeft1", "RedWarDiagUpLeft2", "RedWarDiagUpLeft3", "RedWarDiagUpLeft4"],
                    upRightImages: ["RedWarDiagUpRight1", "RedWarDiagUpRight2", "RedWarDiagUpRight3", "RedWarDiagUpRight4"],
                    downLeftImages: ["RedWarDiagDwnLeft1", "RedWarDiagDwnLeft2", "RedWarDiagDwnLeft3", "RedWarDiagDwnLeft4"],
                    downRightImages: ["RedWarDiagDwnRight1", "RedWarDiagDwnRight2", "RedWarDiagDwnRight3", "RedWarDiagDwnRight4"]),
        
        "blueWarrior" : (
                    leftImages: ["BlueWarLeft1", "BlueWarLeft2", "BlueWarLeft3", "BlueWarLeft4"],
                    rightImages: ["BlueWarRight1", "BlueWarRight2", "BlueWarRight3", "BlueWarRight4"],
                    downImages: ["BlueWarDwn1", "BlueWarDwn2", "BlueWarDwn3", "BlueWarDwn4"],
                    upImages: ["BlueWarUp1", "BlueWarUp2", "BlueWarUp3", "BlueWarUp4"],
                    upLeftImages: ["BlueWarDiagUpLeft1", "BlueWarDiagUpLeft2", "BlueWarDiagUpLeft3", "BlueWarDiagUpLeft4"],
                    upRightImages: ["BlueWarDiagUpRight1", "BlueWarDiagUpRight2", "BlueWarDiagUpRight3", "BlueWarDiagUpRight4"],
                    downLeftImages: ["BlueWarDiagDwnLeft1", "BlueWarDiagDwnLeft2", "BlueWarDiagDwnLeft3", "BlueWarDiagDwnLeft4"],
                    downRightImages: ["BlueWarDiagDwnRight1", "BlueWarDiagDwnRight2", "BlueWarDiagDwnRight3", "BlueWarDiagDwnRight4"]),
        
        "pinkWarrior" : (
                    leftImages: ["PinkWarLeft1", "PinkWarLeft2", "PinkWarLeft3", "PinkWarLeft4"],
                    rightImages: ["PinkWarRight1", "PinkWarRight2", "PinkWarRight3", "PinkWarRight4"],
                    downImages: ["PinkWarDwn1", "PinkWarDwn2", "PinkWarDwn3", "PinkWarDwn4"],
                    upImages: ["PinkWarUp1", "PinkWarUp2", "PinkWarUp3", "PinkWarUp4"],
                    upLeftImages: ["PinkWarDiagUpLeft1", "PinkWarDiagUpLeft2", "PinkWarDiagUpLeft3", "PinkWarDiagUpLeft4"],
                    upRightImages: ["PinkWarDiagUpRight1", "PinkWarDiagUpRight2", "PinkWarDiagUpRight3", "PinkWarDiagUpRight4"],
                    downLeftImages: ["PinkWarDiagDwnLeft1", "PinkWarDiagDwnLeft2", "PinkWarDiagDwnLeft3", "PinkWarDiagDwnLeft4"],
                    downRightImages: ["PinkWarDiagDwnRight1", "PinkWarDiagDwnRight2", "PinkWarDiagDwnRight3", "PinkWarDiagDwnRight4"]),
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

