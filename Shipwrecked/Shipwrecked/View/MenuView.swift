//
//  View.swift
//  Shipwrecked
//
//  Created by Forrest Arnold on 03/05/1402 AP.
//

import SwiftUI
import SpriteKit

struct MenuView: View {
    
    @StateObject var scene = SKScene(fileNamed: "CaveScene.sks") as! GameScene
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cyan.opacity(0.5).edgesIgnoringSafeArea(.all)
                Color.white.opacity(0.1).edgesIgnoringSafeArea(.all)
                
                Image("BeachForMenu")
                    .resizable().scaledToFill().edgesIgnoringSafeArea(.all).padding(.top, 25)
                
                NavigationLink {
                    SelectPlayerView().navigationBarBackButtonHidden(true)
                } label: {
                    Text("SHIPWRECKED")
                        .font(CustomFontBlock.title).kerning(3.5).foregroundColor(.black).padding(.bottom).shadow(color: .white, radius: 2.5)
                }
            }
        }
        .environmentObject(scene)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().previewInterfaceOrientation(.landscapeRight)
    }
}
