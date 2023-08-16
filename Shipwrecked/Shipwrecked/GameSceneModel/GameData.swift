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
    @Published var currentWeapon: InventoryItem?
    @Published var collectedBoatMaterial1 = false
    @Published var collectedBoatMaterial2 = false
    @Published var collectedBoatMaterial3 = false
    @Published var inventory: [InventoryItem] = [
        InventoryItem(name: "Cutlass", imageName: "Cutlass", itemDescription: "Bendy sword", isWeapon: true, isFood: false, isRanged: false),
        InventoryItem(name: "Clam", imageName: "Clam", itemDescription: "Nothin special", isWeapon: false, isFood: false, isRanged: false),
        InventoryItem(name: "Flintlock", imageName: "FlintLock", itemDescription: "Pew thing", isWeapon: true, isFood: false, isRanged: true),
        InventoryItem(name: "Knife", imageName: "Knife", itemDescription: "Stabber", isWeapon: true, isFood: false, isRanged: false),
        InventoryItem(name: "Twig", imageName: "Twig", itemDescription: "Poker", isWeapon: true, isFood: false, isRanged: false)
        ]
    
    @Published var currentLevel: Level = .scene
    
    init() {}
}
