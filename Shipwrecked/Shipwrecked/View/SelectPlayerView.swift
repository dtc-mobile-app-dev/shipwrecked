
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
            Image("BoatPiecesOnBeachWithTrees")
                .resizable()
                .ignoresSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: 375)
            
            VStack {
                Text("SELECT A CHARACTER TO CONTINUE")
                    .font(CustomFontBlock.medium)
                    .foregroundColor(.black)
                    .shadow(color: .white, radius: 2.5)
                    .padding(.bottom, 275)
            }
            
            HStack(spacing: -50) {
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

