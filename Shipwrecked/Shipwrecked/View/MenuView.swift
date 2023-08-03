//
//  View.swift
//  Shipwrecked
//
//  Created by Forrest Arnold on 03/05/1402 AP.
//

import SwiftUI
import SpriteKit

/// FIRST SCREEN OR LOADING SCREEN

struct MenuView: View {
    
    @StateObject var scene = SKScene(fileNamed: "IslandScene.sks") as! GameScene
        
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                Image("Beach")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.25)
                    .padding(.top, 25)
                
                NavigationLink {
                    SelectPlayerView()
                        .navigationBarBackButtonHidden(true)
                    
                } label: {
                    Text("SHIPWRECKED")
                        .font(CustomFontBlock.title)
                        .kerning(2.5)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width, alignment: .bottom)
                        .padding(.top, 50)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().previewInterfaceOrientation(.landscapeRight)
    }
}
