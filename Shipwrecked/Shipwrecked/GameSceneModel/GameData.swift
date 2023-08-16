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
    

    var currentPlayerPositionX: Double = -1000
    var currentPlayerPositionY: Double = 0
    @Published var currentWeapon: Weapon?
    @Published var collectedBoatMaterial1 = false
    @Published var collectedBoatMaterial2 = false
    @Published var collectedBoatMaterial3 = false
    @Published var inventory: [InventoryItem] = [
        InventoryItem(name: "Cutlass", imageName: "Cutlass", itemDescription: "Bendy sword", isWeapon: true, isFood: false),
        InventoryItem(name: "Clam", imageName: "Clam", itemDescription: "Nothin special", isWeapon: false, isFood: false),
        InventoryItem(name: "Chest", imageName: "Chest", itemDescription: "MAN would this be cool if we coded something for it", isWeapon: false, isFood: false),
        InventoryItem(name: "Boomerang", imageName: "Boomerang", itemDescription: "Whoosh", isWeapon: true, isFood: false),
        InventoryItem(name: "Skull 1", imageName: "Skull1", itemDescription: "From the islands previous visitors", isWeapon: false, isFood: false),
        InventoryItem(name: "Oar", imageName: "Oar1", itemDescription: "Boat Material", isWeapon: false, isFood: false),
        InventoryItem(name: "Stick Guy", imageName: "SentientStick1", itemDescription: "Boat Material", isWeapon: false, isFood: false),
        InventoryItem(name: "Wood Plank", imageName: "WoodPlank1", itemDescription: "Boat Material", isWeapon: false, isFood: false),
        InventoryItem(name: "Watermelon", imageName: "Watermelon", itemDescription: "Speed Boost maybe, or just some heals", isWeapon: false, isFood: true),
        InventoryItem(name: "Note", imageName: "Note", itemDescription: "Read Me", isWeapon: false, isFood: false),
        InventoryItem(name: "Apple", imageName: "Apple", itemDescription: "Yummy green", isWeapon: false, isFood: true)
        ]
    
    @Published var currentLevel: Level = .scene
    
    init() {}
}
