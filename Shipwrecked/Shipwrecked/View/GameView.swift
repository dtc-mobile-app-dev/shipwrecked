//
//  ContentView.swift
//  DEMO TilemapGame
//
//  Created by Asher McConnell on 7/25/23.
//

import SwiftUI
import SpriteKit

enum Level {
    case jungleScene
    case scene
    case caveScene
    case volcanoScene
    
}

struct GameView: View {

    @EnvironmentObject var scene: IslandScene
    @EnvironmentObject var caveScene: CaveScene
    @EnvironmentObject var jungleScene: JungleScene
    @EnvironmentObject var volcanoScene: VolcanoScene

    
    @State var location: CGPoint = .zero
    @State var innerCircleLocation: CGPoint = .zero
    
    
    @GestureState var fingerLocation: CGPoint? = nil
    @GestureState var startLocation: CGPoint? = nil
    
    @State var score = 0
    @State var angle = 0
    
    let bigCircleRadius: CGFloat = 100
    
    @State var items = [
        InventoryItem(name: "Cutlass", imageName: "Cutlass", itemDescription: "Bendy sword"),
        InventoryItem(name: "Clam", imageName: "Clam", itemDescription: "Nothin special"),
        InventoryItem(name: "Chest", imageName: "Chest", itemDescription: "MAN would this be cool if we coded something for it"),
        InventoryItem(name: "Boomerang", imageName: "Boomerang", itemDescription: "Whoosh"),
        InventoryItem(name: "Skull 1", imageName: "Skull1", itemDescription: "From the islands previous visitors"),
        InventoryItem(name: "Skull 2", imageName: "Skull2", itemDescription: "From the islands previous visitors"),
        InventoryItem(name: "Boomerang 2", imageName: "Boomerang2", itemDescription: "Shoosh"),
        InventoryItem(name: "Watermelon", imageName: "Watermelon", itemDescription: "Speed Boost maybe, or just some heals"),
        InventoryItem(name: "Note", imageName: "Note", itemDescription: "Read Me"),
        InventoryItem(name: "WoodPlank", imageName: "WoodPlank", itemDescription: "For the boat maybe")
    ]
    
    @State var showInventory = false
    @State var isAHint = false
    @State var isASign = false {
        didSet { isAHint.toggle() }
    }
    
//    let item: InventoryItem
    @State var showItem = false
    @State var showButtonText = "Show Item"
    @State var inventoryDescription = "Nothing"
    @State var showInventoryDescription = false
    
    
    
    var body: some View {
        ZStack {
        
            switch GameData.shared.currentLevel {
            case .jungleScene:
                SpriteView(scene: jungleScene)
                    .ignoresSafeArea()
            case .scene:
                SpriteView(scene: scene)
                    .ignoresSafeArea()
            case .caveScene:
                SpriteView(scene: caveScene)
                    .ignoresSafeArea()
            case .volcanoScene:
                SpriteView(scene: volcanoScene)
                    .ignoresSafeArea()
            }
                   
            rightstick
                .position(x:Constants.controllerPositionX, y: Constants.controllerPositionY)
            
                .overlay {
                    uiOverlay
                }
            Text(angleText)
                .offset(y: -1000)
            
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
        caveScene.updateAngle(isAttacking: isAttacking, degree: degrees)
        jungleScene.updateAngle(isAttacking: isAttacking, degree: degrees)
        volcanoScene.updateAngle(isAttacking: isAttacking, degree: degrees)
        
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
                ForEach(IslandScene().inventory) { item in
                    Button {
                        inventoryDescription = item.itemDescription
                        showInventoryDescription.toggle()
                    } label: {
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
            .opacity(showInventory ? 1 : 0)
            .animation(.linear(duration: showInventory ? 0.3 : 0.1), value: showInventory)
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            ZStack {
                Image("InventoryDescription")
                    .resizable()
                    .frame(width: showInventoryDescription && showInventory ? 160 : 0, height: showInventoryDescription && showInventory ? 220 : 0)
                    .padding(EdgeInsets(top: 50, leading: 560, bottom: 0, trailing: 0))
                Text(items[1].itemDescription)
                    .opacity(showInventoryDescription && showInventory ? 1.0 : 0)
                    .padding(EdgeInsets(top: 50, leading: 560, bottom: 0, trailing: 0))
                HStack{
                    Button {
                        // Make this button equip or consume or look at item depending on what the item is
                    } label: {
                        ZStack {
                            if showInventoryDescription && showInventory {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(.brown)
                                    .frame(width: 70, height: 40)
                                Text("Use")
                                    .foregroundColor(.black)
                            }
                        }
                        .opacity(showInventoryDescription ? 1.0 : 0)
                    }
                    Button {
                        // Make this button get rid of the item that is selected
                        IslandScene().inventory.remove(at: 0)
                    } label: {
                        ZStack {
                            if showInventoryDescription && showInventory {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(.brown)
                                    .frame(width: 70, height: 40)
                                //.padding(EdgeInsets(top: 200, leading: 400, bottom: 0, trailing: 0))
                                Text("Trash")
                                    .foregroundColor(.black)
                                //.padding(EdgeInsets(top: 200, leading: 400, bottom: 0, trailing: 0))
                            }
                        }
                        .opacity(showInventoryDescription ? 1.0 : 0)
                    }
                }
            }
            
            // MARK: - Signs
            
          
            VStack {
                HStack {
                    Image("HealthBar6MAX")
                        .resizable()
                        .scaledToFill().padding()
                        .frame(width: 250, height: 20)
                        .shadow(color: .white, radius: 15)
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
                            .shadow(color: .white, radius: 15)
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
    
//    func createSignLabel(text: String) -> SKLabelNode {
//        let node = SKLabelNode(text: text)
//        node.verticalAlignmentMode = .center
//        return node
//    }
    
    // MARK: - BEACH NOTES
    var beachNote1: some View {
        ZStack {
            Image("BlankPaper")
                .resizable().frame(width: 500, height: 300).padding(.top, 25)
                .overlay {
                    Text("NOTE: Your crew members have been captured! Find them and get off the island before it's too late!")
                        .frame(width: 350, height: 200).font(CustomFontBlock.small)
                }
        }
    }
    var beachNote2: some View {
        ZStack {
            Image("BlankPaper")
                .resizable().frame(width: 500, height: 300).padding(.top, 25)
                .overlay {
                    Text("NOTE: Collect things you find along the way and use them to save the crew!")
                        .frame(width: 350, height: 200).font(CustomFontBlock.small)
                }
        }
    }
    // MARK: - BEACH NOTES/SIGNS
    
    var signBeach1: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .overlay {
                    Text("Entrance to the Cave of the Beast")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var signBeach2: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .overlay {
                    Text("Entrance to the Depths of the Volcano")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var signBeach3: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .overlay {
                    Text("Entrance to the Green of the Jungle")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    // MARK: - NOT A SIGN IS BLANK PAPER FOR NOTES
    var noteBeach1: some View {
        ZStack {
            Image("BlankPaper")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 25)
                .overlay {
                    Text("What is Kevin doing here? He does literally nothing! - Gerald the Gunner")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var noteBeach2: some View {
        ZStack {
            Image("BlankPaper")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 25)
                .overlay {
                    Text("Captain Doug is Kinda Smelly - Lizzie The Welder")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var noteBeach3: some View {
        ZStack {
            Image("BlankPaper")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 25)
                .overlay {
                    Text("Gerald is giving me a mean look, I don't think he likes me. I might have to throw him overboard. - Kevin")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var noteBeach4: some View {
        ZStack {
            Image("BlankPaper")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 25)
                .overlay {
                    Text("Lizzie don't like the sea, and if she don't like the sea, me don't like she - Captain Doug")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    // MARK: - IS DIFFERENT PAPER. DONT USE FOR SIGNS BECAUSE TEXT WON'T FIT
//    var paperBeach1: some View {
//        ZStack {
//            Image("Paper1")
//                .resizable()
//                .frame(width: 600, height: 300)
//                .padding(.top, 50)
//                .overlay {
//                    Text("Text for BEACH clue #3")
//                        .frame(width: 350, height: 200)
//                        .font(CustomFontBlock.small)
//                }
//        }
//    }
    
    // Cave Signs
    var signCave1: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .opacity(caveScene.cave1SignImage)
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
                .opacity(caveScene.cave2SignImage)
                .overlay {
                    Text("BEWARE!: This Hellish creature produce Sonic Sound Waves that can cause harm to those around")
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
                .opacity(caveScene.cave3SignImage)
                .overlay {
                    Text("Feed the Beast weekly, we don't want to make it upset")
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
                .opacity(caveScene.cave4SignImage)
                .overlay {
                    Text("The beast can attack from a distance")
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
                .opacity(volcanoScene.volcano1SignImage)
                .overlay {
                    Text("WATCH YOUR STEP!")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var signVolcano2: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .opacity(volcanoScene.volcano2SignImage)
                .overlay {
                    Text("Perform Sacrificial Rituals to prevent the Lava God from unleashing its anger upon us")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var signVolcano3: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .opacity(volcanoScene.volcano3SignImage)
                .overlay {
                    Text("Don't Forget Sunscreen and Stay Hydrated due to the intense heat")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var signVolcano4: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .opacity(volcanoScene.volcano4SignImage)
                .overlay {
                    Text("CAUTION: If angered, It will throw lava")
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
                .opacity(jungleScene.jungle1SignImage)
                .overlay {
                    Text("The Protector of the Green watches for intruders")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var signForest2: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .opacity(jungleScene.jungle2SignImage)
                .overlay {
                    Text("PROTECT THE GREEN")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var signForest3: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .opacity(jungleScene.jungle3SignImage)
                .overlay {
                    Text("A Sword of Unfathomable Power is within the Green")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var signForest4: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .opacity(jungleScene.jungle4SignImage)
                .overlay {
                    Text("The Protector desires peace. DO NOT PROVOKE")
                        .frame(width: 350, height: 200)
                        .font(CustomFontBlock.small)
                }
        }
    }
    var signSword1: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .overlay {
                    Text("Only those worthy can hold the Sword of the Green")
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
    let itemDescription: String
}





