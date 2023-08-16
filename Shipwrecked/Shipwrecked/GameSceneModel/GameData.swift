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
    
    @Published var currentHealth = 6
    @Published var playerHealthArray = ["HealthBar0MIN", "HealthBar1", "HealthBar2", "HealthBar3", "HealthBar4", "HealthBar5", "HealthBar6MAX"]
    var currentPlayer: Player?
    
    var caveCrewMemberRescued = false
    var jungleCrewMemberRescued = false
    var volcanoCrewMemberRescued = false

    var currentPlayerPositionX: Double = -1400
    var currentPlayerPositionY: Double = 0
    @Published var currentWeapon: Weapon?
    @Published var collectedBoatMaterial1 = false
    @Published var collectedBoatMaterial2 = false
    @Published var collectedBoatMaterial3 = false
    @Published var inventory: [InventoryItem] = [
        InventoryItem(name: "Cutlass", imageName: "Cutlass", itemDescription: "Bendy sword", isWeapon: true, isFood: false),
        InventoryItem(name: "Clam", imageName: "Clam", itemDescription: "Nothin special", isWeapon: false, isFood: false),
        ]
    
    @Published var currentLevel: Level = .scene
    
    init() {}
}
