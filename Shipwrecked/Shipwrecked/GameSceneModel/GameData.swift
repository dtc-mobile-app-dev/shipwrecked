//
//  GameData.swift
//  Shipwrecked
//
//  Created by Asher McConnell on 8/12/23.
//

import SpriteKit
import SwiftUI

class GameData: ObservableObject {
    
    static let shared = GameData()
    
    @Published var currentHealth = 0
    var currentPlayer: Player?
    
    var currentPlayerPositionX: Double = 1500
    var currentPlayerPositionY: Double = 1500
    @Published var currentWeapon: Weapon?
    @Published var inventory: [InventoryItem]?
    
    @Published var currentLevel: Level = .scene
    
    init() {}
}
