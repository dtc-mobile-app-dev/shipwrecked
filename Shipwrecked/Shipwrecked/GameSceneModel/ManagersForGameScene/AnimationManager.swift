//
//  AnimationManager.swift
//  Shipwrecked
//
//  Created by Asher McConnell on 8/1/23.
//

import SwiftUI
import SpriteKit

class AnimationManager {
    
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
                    downImages: ["GunnerDown1", "GunnerDown2", "GunnerDown3", "GunnerDown4"],
                    upImages: ["GunnerUp1", "GunnerUp2", "GunnerUp3", "GunnerUp4"],
                    upLeftImages: ["GunnerDiagUpLeft1", "GunnerDiagUpLeft2", "GunnerDiagUpLeft3", "GunnerDiagUpLeft4"],
                    upRightImages: ["GunnerDiagUpRight1", "GunnerDiagUpRight2", "GunnerDiagUpRight3", "GunnerDiagUpRight4"],
                    downLeftImages: ["GunnerDiagDwnLeft1", "GunnerDiagDwnLeft2", "GunnerDiagDwnLeft3", "GunnerDiagDwnLeft4"],
                    downRightImages: ["GunnerDiagDwnRight1", "GunnerDiagDwnRight2", "GunnerDiagDwnRight3", "GunnerDiagDwnRight4"]),
        "welder" : (
                
                    leftImages: ["WelderLeft1", "WelderLeft2", "WelderLeft3", "WelderLeft4"],
                    rightImages: ["WelderRight1", "WelderRight2", "WelderRight3", "WelderRight4"],
                    downImages: ["WelderDown1", "WelderDown2", "WelderDown3", "WelderDown4"],
                    upImages: ["WelderUp1", "WelderUp2", "WelderUp3", "WelderUp4"],
                    upLeftImages: ["WelderDiagonalUpLeft1", "WelderDiagonalUpLeft2", "WelderDiagonalUpLeft3", "WelderDiagonalUpLeft4"],
                    upRightImages: ["WelderDiagonalUpRight1", "WelderDiagonalUpRight2", "WelderDiagonalUpRight3", "WelderDiagonalUpRight4"],
                    downLeftImages: ["DiagonalDownLeft1", "DiagonalDownLeft2", "DiagonalDownLeft3", "DiagonalDownLeft4"],
                    downRightImages: ["DiagonalDownRight1", "DiagonalDownRight2", "DiagonalDownRight3", "DiagonalDownRight4"]),
        "kevin" : (
                    leftImages: ["KevinLeft1", "KevinLeft2", "KevinLeft3", "KevinLeft4"],
                    rightImages: ["KevinRight1", "KevinRight2", "KevinRight3", "KevinRight4"],
                    downImages: ["KevinDown1", "KevinDown2", "KevinDown3", "KevinDown4"],
                    upImages: ["KevinUp1", "KevinUp2", "KevinUp3", "KevinUp4"],
                    upLeftImages: ["KevinDiagonalUpLeft1", "KevinDiagonalUpLeft2", "KevinDiagonalUpLeft3", "KevinDiagonalUpLeft4"],
                    upRightImages: ["KevinDiagonalUpRight1", "KevinDiagonalUpRight2", "KevinDiagonalUpRight3", "KevinDiagonalUpRight4"],
                    downLeftImages: ["KevinDiagonalDownLeft1", "KevinDiagonalDownLeft2", "KevinDiagonalDownLeft3", "KevinDiagonalDownLeft4"],
                    downRightImages: ["KevinDiagonalDownRight1", "KevinDiagonalDownRight2", "KevinDiagonalDownRight3", "KevinDiagonalDownRight4"]),
        "redWarrior" : (
                    leftImages: ["RedWarLeft1", "RedWarLeft2", "RedWarLeft3", "RedWarLeft4"],
                    rightImages: ["RedWarRight1", "RedWarRight2", "RedWarRight3", "RedWarRight4"],
                    downImages: ["RedWarDown1", "RedWarDown2", "RedWarDown3", "RedWarDown4"],
                    upImages: ["RedWarUp1", "RedWarUp2", "RedWarUp3", "RedWarUp4"],
                    upLeftImages: ["RedWarDiagonalUpLeft1", "RedWarDiagonalUpLeft2", "RedWarDiagonalUpLeft3", "RedWarDiagonalUpLeft4"],
                    upRightImages: ["RedWarDiagonalUpRight1", "RedWarDiagonalUpRight2", "RedWarDiagonalUpRight3", "RedWarDiagonalUpRight4"],
                    downLeftImages: ["RedWarDiagDownLeft1", "RedWarDiagDownLeft2", "RedWarDiagDownLeft3", "RedWarDiagDownLeft4"],
                    downRightImages: ["RedWarDiagDownRight1", "RedWarDiagDownRight2", "RedWarDiagDownRight3", "RedWarDiagDownRight4"]),
        
        "blueWarrior" : (
                    leftImages: ["BlueWarLeft1", "BlueWarLeft2", "BlueWarLeft3", "BlueWarLeft4"],
                    rightImages: ["BlueWarRight1", "BlueWarRight2", "BlueWarRight3", "BlueWarRight4"],
                    downImages: ["BlueWarDown1", "BlueWarDown2", "BlueWarDown3", "BlueWarDown4"],
                    upImages: ["BlueWarUp1", "BlueWarUp2", "BlueWarUp3", "BlueWarUp4"],
                    upLeftImages: ["BlueWarDiagonalUpLeft1", "BlueWarDiagonalUpLeft2", "BlueWarDiagonalUpLeft3", "BlueWarDiagonalUpLeft4"],
                    upRightImages: ["BlueWarDiagonalUpRight1", "BlueWarDiagonalUpRight2", "BlueWarDiagonalUpRight3", "BlueWarDiagonalUpRight4"],
                    downLeftImages: ["BlueWarDiagonalDownLeft1", "BlueWarDiagonalDownLeft2", "BlueWarDiagonalDownLeft3", "BlueWarDiagonalDownLeft4"],
                    downRightImages: ["BlueWarDiagonalDownRight1", "BlueWarDiagonalDownRight2", "BlueWarDiagonalDownRight3", "BlueWarDiagonalDownRight4"]),
        
        "pinkWarrior" : (
                    leftImages: ["PinkWarLeft1", "PinkWarLeft2", "PinkWarLeft3", "PinkWarLeft4"],
                    rightImages: ["PinkWarRight1", "PinkWarRight2", "PinkWarRight3", "PinkWarRight4"],
                    downImages: ["PinkWarDown1", "PinkWarDown2", "PinkWarDown3", "PinkWarDown4"],
                    upImages: ["PinkWarUp1", "PinkWarUp2", "PinkWarUp3", "PinkWarUp4"],
                    upLeftImages: ["PinkWarDiagonalUpLeft1", "PinkWarDiagonalUpLeft2", "PinkWarDiagonalUpLeft3", "PinkWarDiagonalUpLeft4"],
                    upRightImages: ["PinkWarDiagonalUpRight1", "PinkWarDiagonalUpRight2", "PinkWarDiagonalUpRight3", "PinkWarDiagonalUpRight4"],
                    downLeftImages: ["PinkWarDiagonalDownLeft1", "PinkWarDiagonalDownLeft2", "PinkWarDiagonalDownLeft3", "PinkWarDiagonalDownLeft4"],
                    downRightImages: ["PinkWarDiagonalDownRight1", "PinkWarDiagonalDownRight2", "PinkWarDiagonalDownRight3", "PinkWarDiagonalDownRight4"]),
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

