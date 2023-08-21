//
//  SceneConstants.swift
//  Shipwrecked
//
//  Created by Asher McConnell on 8/21/23.
//

import SwiftUI

struct SceneConstants {
    
    // MARK: - ENEMY
    
    static let enemyHealth = 3
    static let enemyStrength = 1
    
    // MARK: - Player
    
    static let playerZposition = 5
    static let playerScale = 0.5
    static let playerWidth: Double = 2
    static let playerHeight: Double = 10
    
    static let diagonalMove = 2.8
    static let dPadMove = 5.0
    
    // MARK: GUN
    
    static let gunZPosition: CGFloat = 4
    static let gunScale: CGFloat = 0.8
    static let gunAnchorX = -0.2
    static let gunAnchorY = 0.5
    static let gunDuration = 1.0
    static let gunFireVolume: Float = 0.4
    
    static let bulletImage = "CannonBall"
    static let bulletZPosition: CGFloat = 3
    static let bulletScale: CGFloat = 0.1
    static let bulletWidth: Double = 3
    static let bulletHeight: Double = 1.6
    static let bulletAnchorX = 0.0
    static let bulletAnchorY = -0.15
    static let bulletTimer = 1.0
    
    // MARK: - Melee
    
    static let meleeScale = 1.0
    static let meleeZPosition: CGFloat = 5
    static let meleeWidth: Double = 3
    static let meleeHeight: Double = 1.6
    static let meleeAnchorX = 0.0
    static let meleeAnchorY = -0.2
    static let swingDuration = 0.7
    static let meleeTimer = 1.0
    static let swingAngle: Double = 2 / 3
    static let swingRotation: Double = 4 * 8.3
    
    // MARK: - CAMERA
    
    static let camScale: CGFloat = 2
    static let camZPosition: CGFloat = 10
    
    // MARK: - BOSS
    
    static let bossAttackAngle = 7.0
    static let projecticleDistance: CGFloat = 2000
    static let projectileDuration: Double = 4.0
}
