//
//  Item.swift
//  Shipwrecked
//
//  Created by Forrest Arnold on 11/05/1402 AP.
//

import Foundation
import SwiftUI

struct InventoryItem: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

// Dont need these
struct Weapon {
    let name: String
    let image: Image
    let damage: Int
    var isGun: Bool
}

struct Consumable {
    let name: String
    let image: Image
    let heal: Int
}
