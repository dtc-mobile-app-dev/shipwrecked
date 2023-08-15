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
    

    var currentPlayerPositionX: Double?
    var currentPlayerPositionY: Double?
    @Published var currentWeapon: Weapon?
    @Published var inventory: [InventoryItem] = [
        InventoryItem(name: "Apple", imageName: "Apple", itemDescription: "Yum"),
        InventoryItem(name: "Watermelon", imageName: "Watermelon", itemDescription: "Wooooo"),
        InventoryItem(name: "Boomerang" , imageName: "Boomerang", itemDescription: "WHOOOSH"),
        InventoryItem(name: "Skull", imageName: "Skull1", itemDescription: "OH NOO")
        ]
    
    @Published var currentLevel: Level = .scene
    
    init() {}
}
