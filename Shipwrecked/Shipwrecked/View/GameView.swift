//
//  ContentView.swift
//  DEMO TilemapGame
//
//  Created by Asher McConnell on 7/25/23.
//

import SwiftUI
import SpriteKit


struct GameView: View {
    
    @State var showInventory = false
    
    @StateObject var scene = SKScene(fileNamed: "IslandScene.sks") as! GameScene
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
            Button {
                showInventory.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.red)
                    .frame(width: 220, height: 120)
                    .padding(EdgeInsets.init(top: 0, leading: 200, bottom: 0, trailing: 0))
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

