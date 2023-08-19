//
//  View.swift
//  Shipwrecked
//
//  Created by Forrest Arnold on 03/05/1402 AP.
//

import SwiftUI
import SpriteKit

struct MenuView: View {
    
    @StateObject var scene = SKScene(fileNamed: "IslandScene.sks")! as! IslandScene
    @StateObject var jungleScene = SKScene(fileNamed: "JungleScene.sks") as! JungleScene
    @StateObject var caveScene = SKScene(fileNamed: "CaveScene.sks") as! CaveScene
    @StateObject var volcanoScene = SKScene(fileNamed: "VolcanoScene.sks") as! VolcanoScene
        
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
                        .font(CustomFontBlock.title).kerning(5).foregroundColor(.black).shadow(color: .white, radius: 3.5)
                }
            }
            .onAppear {
                SoundManager.instance.playMusic(sound: .IslandTheme, volume: 0.5, loops: 5)
            }
        }
        .environmentObject(scene)
        .environmentObject(jungleScene)
        .environmentObject(caveScene)
        .environmentObject(volcanoScene)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().previewInterfaceOrientation(.landscapeRight)
    }
}

