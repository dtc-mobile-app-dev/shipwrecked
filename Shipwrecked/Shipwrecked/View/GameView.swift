//
//  ContentView.swift
//  DEMO TilemapGame
//
//  Created by Asher McConnell on 7/25/23.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    
    @StateObject var scene = SKScene(fileNamed: "VolcanoScene.sks") as! GameScene
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()

                .overlay {
                    UIOverlay()
                }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

