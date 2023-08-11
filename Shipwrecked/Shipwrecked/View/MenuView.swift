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
//                Image("AlsoKilledTheDinosaurs300")
//                Image("WaterFire300")
                Image("BeachForMenu")
                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea(.all)
//                    .frame(width: UIScreen.main.bounds.width).padding(.leading, 225)
//                    .scaleEffect(1.25)
//                    .frame(height: UIScreen.main.bounds.height).padding(.top, 150)
//                    .frame(width: UIScreen.main.bounds.width).padding(.top, 100)

                NavigationLink {
                    SelectPlayerView().navigationBarBackButtonHidden(true)
                } label: {
                    Text("SHIPWRECKED")
                        .font(CustomFontBlock.title)
                        .kerning(5)
                        .foregroundColor(.black)
                        .shadow(color: .white, radius: 1.5)
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
