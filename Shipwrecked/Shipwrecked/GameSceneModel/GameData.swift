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
    
    var currentHealth = 0
    var currentPlayer: Player?
    
    var currentPlayerPositionX: Double?
    var currentPlayerPositionY: Double?
    var currentWeapon: Weapon?
    var inventory: [InventoryItem]?
    
    @Published var currentLevel: Level = .scene
    
    @Published var islandSceneActive = true
    @Published var caveSceneActive = false
    @Published var jungleSceneActive = false
    @Published var volcanoSceneActive = false
    
    init() {}
}
