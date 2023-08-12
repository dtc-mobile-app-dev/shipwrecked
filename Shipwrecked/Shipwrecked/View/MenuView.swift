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
//                Image("AlsoKilledTheDinosaurs300")
//                Image("WaterFire300")
                Image("BeachForMenu")
                    .resizable()
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height).padding(.top, 50)
                    .scaledToFill()
                    .padding(.top).edgesIgnoringSafeArea(.all)
//                    .frame(width: UIScreen.main.bounds.width).padding(.leading, 225)
//                    .scaleEffect(1.25)
//                    .frame(height: UIScreen.main.bounds.height).padding(.top, 150)
//                    .frame(width: UIScreen.main.bounds.width).padding(.top, 100)

                NavigationLink {
                    SelectPlayerView().navigationBarBackButtonHidden(true)
                } label: {
                    Text("SHIPWRECKED")
                        .font(CustomFontBlock.title)
                        .kerning(2.5)
                        .foregroundColor(.black)
                        .padding(.bottom)
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
