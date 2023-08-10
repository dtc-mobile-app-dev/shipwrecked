
//
//  SelectPlayerView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/1/23.
//

import SwiftUI
import SpriteKit

struct SelectPlayerView: View {
    
    @ObservedObject var scene: GameScene
    
    @State var playerIsSelected = false
    @State var goToNextView = StoryView(scene: GameScene())
    

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("select a character to continue")
                    .font(CustomFont8Bit.medium)
                    .foregroundColor(.white)
                    .padding(.bottom, 315)
            }
            
                HStack(spacing: -25) {
                    Button {
                        scene.currentPlayer = Player(character: "GunnerRight1", weapon: "gunner", heathPoints: 10)
                        self.playerIsSelected.toggle()
                    } label: {
                        Image("GunnerProfilePic").scaledToFit()
                            .padding(.top, 50)
                            .shadow(color: .white.opacity(0.25), radius: 5)
                    }
                    
                    Button {
                        scene.currentPlayer = Player(character: "WelderRight1", weapon: "welder", heathPoints: 10)
                        self.playerIsSelected.toggle()
                    } label: { Image("WelderProfilePic").scaledToFit().padding(.top, 75).shadow(color: .white.opacity(0.25), radius: 5) }
                    
                    Button {
                        scene.currentPlayer = Player(character: "KevinRight1", weapon: "kevin", heathPoints: 10)
                        self.playerIsSelected.toggle()
                    } label: { Image("KevinProfilePic").scaledToFill().padding(.top, 50).shadow(color: .white.opacity(0.25), radius: 5) }
                      
                }
          
            if playerIsSelected {
                goToNextView
                
            }
        }
    }
}


struct SelectPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPlayerView(scene: GameScene()).previewInterfaceOrientation(.landscapeRight)
    }
}
