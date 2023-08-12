
//
//  SelectPlayerView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/1/23.
//

import SwiftUI

struct SelectPlayerView: View {
    
    @EnvironmentObject var scene: GameScene
    
    @State var playerIsSelected = false
    @State var goToNextView = StoryView()
    
    var body: some View {
        ZStack {
            Color.cyan.opacity(0.5).edgesIgnoringSafeArea(.all)
            Color.white.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            Image("BoatPiecesOnBeachWithTreesMenu")
                .resizable()
                .ignoresSafeArea(.all)
                .scaledToFit()
                .padding(.top, 50)
            
            VStack {
                Text("SELECT A CHARACTER TO CONTINUE")
                    .font(CustomFontBlock.medium).kerning(1)
                    .foregroundColor(.black)
                    .shadow(color: .white, radius: 2.5)
                    .padding(.bottom, 275)
                    .frame(width: UIScreen.main.bounds.width)
            }
            
            HStack(spacing: -503) {
                Button { scene.currentPlayer = Player(character: "GunnerRight1", weapon: "gunner", heathPoints: 10)
                    self.playerIsSelected.toggle()
                } label: {
                    Image("GunnerProfilePic").resizable().frame(width: 225, height: 225)
                        .padding(.top, 125)
                }
                Button { scene.currentPlayer = Player(character: "WelderRight1", weapon: "welder", heathPoints: 10)
                    self.playerIsSelected.toggle()
                } label: { Image("WelderProfilePic").resizable().frame(width: 200, height: 200)
                        .padding(.top, 175)
                }
                Button { scene.currentPlayer = Player(character: "KevinRight1", weapon: "kevin", heathPoints: 10)
                    self.playerIsSelected.toggle()
                } label: { Image("KevinProfilePic").resizable()
                        .frame(width: 225, height: 225)
                        .padding(.top, 125)
                    
                }
            }
            
            if playerIsSelected { goToNextView }
        }
    }
}

struct SelectPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPlayerView().previewInterfaceOrientation(.landscapeRight)
    }
}

