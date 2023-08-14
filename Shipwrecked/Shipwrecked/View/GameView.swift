//
//  ContentView.swift
//  DEMO TilemapGame
//
//  Created by Asher McConnell on 7/25/23.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    
    @EnvironmentObject var scene: VolcanoScene
//    @StateObject var jungleScene = SKScene(fileNamed: "JungleScene.sks") as! JungleScene
//    @StateObject var caveScene = SKScene(fileNamed: "CaveScene.sks") as! CaveScene
//    @StateObject var volcanoScene = SKScene(fileNamed: "VolcanoScene.sks") as! VolcanoScene
    
    @State var location: CGPoint = .zero
    @State var innerCircleLocation: CGPoint = .zero
    
    @GestureState var fingerLocation: CGPoint? = nil
    @GestureState var startLocation: CGPoint? = nil
    
    @State var score = 0
    @State var angle = 0
    
    let bigCircleRadius: CGFloat = 100
    
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
    
    
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                    .ignoresSafeArea()
                   
            rightstick
                .position(x:Constants.controllerPositionX, y: Constants.controllerPositionY)

                .overlay {
                    uiOverlay
                }

        }
    }
}

extension GameView {
    
    // MARK: - CONSTANTS
    
    private struct Constants {
        static let controllerPositionX: CGFloat = 1000
        static let controllerPositionY: CGFloat = 350
    }
    
    // MARK: - CONTROLLER VIEW
    
    var rightstick: some View {
        ZStack {
            Circle()
                .foregroundColor(.black.opacity(0.25))
                .frame(width: bigCircleRadius * 2, height: bigCircleRadius * 1.5)
                .position(location)
            
            Circle()
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                .position(innerCircleLocation)
                .gesture(fingerDrag)
        }
        .frame(alignment: .center)
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                
                let distance = sqrt(pow(newLocation.x - location.x, 2) + pow(newLocation.y - location.y, 2))
                
                if distance > bigCircleRadius {
                    let angle = atan2(newLocation.y - location.y, newLocation.x - location.x)
                    newLocation.x = location.x + cos(angle) * bigCircleRadius
                    newLocation.y = location.y + sin(angle) * bigCircleRadius
                }
                
                self.location = newLocation
                self.innerCircleLocation = newLocation
            }
            .updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }
    }
    
    var fingerDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                let distance = sqrt(pow(value.location.x - location.x, 2) + pow(value.location.y - location.y, 2))
                let angle = atan2(value.location.y - location.y, value.location.x - location.x)
                let maxDistance = bigCircleRadius
                let clampedDistance = min(distance, maxDistance)
                let newX = location.x + cos(angle) * clampedDistance
                let newY = location.y + sin(angle) * clampedDistance
                
                innerCircleLocation = CGPoint(x: newX, y: newY)
            }
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
            .onEnded { value in
                let center = location
                innerCircleLocation = center
            }
    }
    
    var angleText: String {
        let angle = atan2(innerCircleLocation.y - location.y, innerCircleLocation.x - location.x)
        var degrees = Int(-angle * 180 / .pi)
        
        if degrees < 0 {
            degrees += 360
        }
        
        var isAttacking = false
        
        if fingerLocation == nil {
            isAttacking = false
        } else {
            isAttacking = true
        }
        
        scene.updateAngle(isAttacking: isAttacking, degree: degrees)
        //        caveScene.updateAngle(isAttacking: isAttacking, degree: degrees)
        //        jungleScene.updateAngle(isAttacking: isAttacking, degree: degrees)
        //        volcanoScene.updateAngle(isAttacking: isAttacking, degree: degrees)
        
        return "\(degrees)°"
    }
    
    var uiOverlay: some View {
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
    
    
    // MARK: - EXTENSION
    
    func createSignLabel(text: String) -> SKLabelNode {
        let node = SKLabelNode(text: text)
        node.verticalAlignmentMode = .center
        
        return node
    }
    
    // Beach Signs
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
    
    // Cave Signs
    var signCave1: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .overlay {
                    Text("CAUTION: Many enter, but NONE have returned!")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var signCave2: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .overlay {
                    Text("BEWARE!: This Hellish creature produce Sonic Sound Waves that can produce harm")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var signCave3: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .overlay {
                    Text("Feed the Beast weekly,")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    
    var signCave4: some View {
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
    // Volcano Signs
    var signVolcano1: some View {
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
    // Forest Signs
    var signForrest1: some View {
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

