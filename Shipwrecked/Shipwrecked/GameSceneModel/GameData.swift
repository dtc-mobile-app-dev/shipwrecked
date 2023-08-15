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
    @Published var inventory: [InventoryItem] = [
        InventoryItem(name: "Cutlass", imageName: "Cutlass", itemDescription: "Bendy sword"),
        InventoryItem(name: "Clam", imageName: "Clam", itemDescription: "Nothin special"),
        InventoryItem(name: "Chest", imageName: "Chest", itemDescription: "MAN would this be cool if we coded something for it"),
        InventoryItem(name: "Boomerang", imageName: "Boomerang", itemDescription: "Whoosh"),
        InventoryItem(name: "Skull 1", imageName: "Skull1", itemDescription: "From the islands previous visitors"),
        InventoryItem(name: "Skull 2", imageName: "Skull2", itemDescription: "From the islands previous visitors"),
        InventoryItem(name: "Boomerang 2", imageName: "Boomerang2", itemDescription: "Shoosh"),
        InventoryItem(name: "Watermelon", imageName: "Watermelon", itemDescription: "Speed Boost maybe, or just some heals")
        ]
    
    @Published var currentLevel: Level = .scene
    
    init() {}
}
