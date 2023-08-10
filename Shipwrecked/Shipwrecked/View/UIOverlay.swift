//
//  UIOverlay.swift
//  Shipwrecked
//
//  Created by Sam Johanson on 8/2/23.
//

import SwiftUI
import SpriteKit

struct UIOverlay: View {
    
    //    var signMessage: SKLabelNode!
    //    var message: String = "" {
    //        didSet {
    //            signMessage.text = "MESSAGE"
    //        }
    //    }
    
    var items: [InventoryItem] = [
    InventoryItem(name: "Cutlass", imageName: "Cutlass"),
    InventoryItem(name: "Clam", imageName: "Clam"),
    InventoryItem(name: "Chest", imageName: "Chest"),
    InventoryItem(name: "Boomerang", imageName: "Boomerang"),
    InventoryItem(name: "Skull 1", imageName: "Skull1"),
    InventoryItem(name: "Skull 2", imageName: "Skull2"),
    InventoryItem(name: "Boomerang 2", imageName: "Boomerang2"),
    InventoryItem(name: "Watermelon", imageName: "Watermelon"),
    InventoryItem(name: "Note", imageName: "Note"),
    InventoryItem(name: "WoodPlank", imageName: "WoodPlank")
    ]
    
    @State var showInventory = true
    @State var isAHint = false
    @State var isASign = false {
        didSet { isAHint.toggle() }
    }
    
    
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
                // MARK: - Inventory
                
                Rectangle()
                    .ignoresSafeArea()
                    .frame(maxWidth: showInventory ? .infinity : 0)
                    .foregroundColor(.clear)
                Image("InventoryMain")
                    .resizable()
                    .frame(width: showInventory ? 650 : 0, height: showInventory ? 420 : 0)
            Text("Inventory")
                .opacity(showInventory ? 1.0 : 0)
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: showInventory ? 275 : 0, trailing: 0))
                .font(CustomFont8Bit.body)
            VStack {
                Spacer()
                HStack {
                    ForEach(0..<6) {_ in
                            Spacer()
                    }
                    Button {
                        withAnimation() {
                            showInventory.toggle()
                        }
                    } label: {
                        Image("InventoryX")
                            .resizable()
                            .frame(width: showInventory ? 40 : 0, height: showInventory ? 40 : 0)
                
                    }
                    Spacer()
                }
                ForEach(0..<6) {_ in
                        Spacer()
                }
            }
            LazyHGrid(rows: Array(repeating: GridItem(.flexible(), spacing: -150), count: 3), spacing: 10) {
                ForEach(items) { item in
                    InventoryItemView(item: item)
                }
            }
            .opacity(showInventory ? 1 : 0)
            .animation(.linear(duration: showInventory ? 0.3 : 0.1), value: showInventory)
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            
            // MARK: - Signs
            
            //            signBeach1
            //                        signBeach2
            //                        signBeach3
            VStack {
                HStack {
                    Image("HealthBar6MAX")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 30)
                        .shadow(color: .white, radius: 25)
                    Spacer()
                    
                    Button {
                        withAnimation {
                            showInventory.toggle()
                        }
                    } label: {
                        Image("ORANGEBOX")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 75, height: 75)
                            .shadow(color: .white, radius: 25)
                            .overlay {
                                Image("InventoryIcon")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .shadow(color: .white, radius: 5)
                                    .padding(.bottom, 5)
                            }
                    }
                }
                Spacer()
            }
        }
    }
}

struct UIOverlay_Previews: PreviewProvider {
    static var previews: some View {
        UIOverlay()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

// MARK: - EXTENSION

extension UIOverlay {
    
    func createSignLabel(text: String) -> SKLabelNode {
        let node = SKLabelNode(text: text)
        node.verticalAlignmentMode = .center
        
        return node
    }
    
    
    var signBeach1: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .overlay {
                    Text("Text for BEACH clue #1 For signs")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    
    var signBeach2: some View {
        ZStack {
            Image("BlankPaper")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 25)
                .overlay {
                    Text("Text For BEACH clue #2")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    
    var signBeach3: some View {
        ZStack {
            Image("Paper1")
                .resizable()
                .frame(width: 600, height: 300)
                .padding(.top, 50)
                .overlay {
                    Text("Text for BEACH clue #3")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
}

struct InventoryItem: Identifiable {
    let id = UUID()
    let slotImage = "InventorySlot"
    let name: String
    let imageName: String
}

struct InventoryItemView: View {
    let item: InventoryItem
    @State var showItem = false
    @State var showButtonText = "Show Item"
    
    var body: some View {
        VStack {
            ZStack {
                Image(item.slotImage)
                    .resizable()
                    .frame(width: 60, height: 60)
                Image(item.imageName)
                    .resizable()
                    .frame(width: 46, height: 46)
                Text(item.name)
                    .font(CustomFontBlock.small)
                    .foregroundColor(.black)
                    .frame(width: 120, height: 20)
                    .padding(EdgeInsets(top: 80, leading: 0, bottom: 0, trailing: 0))
            }
            
        }
    }
}
