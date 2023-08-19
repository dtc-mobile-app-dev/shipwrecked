
//
//  SelectPlayerView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/1/23.
//

import SwiftUI

struct SelectPlayerView: View {
    
    @EnvironmentObject var scene: IslandScene
    @EnvironmentObject var caveScene: CaveScene
    @EnvironmentObject var jungleScene: JungleScene
    @EnvironmentObject var volcanoScene: VolcanoScene

    @State var playerIsSelected = false
    @State var goToNextView = StoryView()
    
    var body: some View {
        ZStack {
            Constants.backgroundColorOne.edgesIgnoringSafeArea(.all)
            Constants.backgroundColorTwo.edgesIgnoringSafeArea(.all)
            
            Constants.playerImage
                .resizable().ignoresSafeArea(.all).scaledToFit().padding(.top, 50)
            
            VStack {
                Constants.playerTitle
                    .font(CustomFontBlock.medium).foregroundColor(.black).shadow(color: .white, radius: 2.5).padding(.bottom, 275).frame(width: UIScreen.main.bounds.width)
            }

            HStack(spacing: -50) {
                Button { GameData.shared.currentPlayer = Player(character: "GunnerRight1", weapon: "gunner", heathPoints: 10)
                    self.playerIsSelected.toggle()
                } label: { Image("GunnerProfilePic").resizable().frame(width: 225, height: 225).padding(.top, 125) }
                Button { GameData.shared.currentPlayer = Player(character: "WelderRight1", weapon: "welder", heathPoints: 10)
                    self.playerIsSelected.toggle()
                } label: { Image("WelderProfilePic").resizable().frame(width: 200, height: 200).padding(.top, 175) }
                Button { GameData.shared.currentPlayer = Player(character: "KevinRight1", weapon: "kevin", heathPoints: 10)
                    self.playerIsSelected.toggle()
                } label: { Image("KevinProfilePic").resizable().frame(width: 225, height: 225).padding(.top, 125) }
            }
            if playerIsSelected { goToNextView }
        }
        .onAppear {
            GameData.shared.currentHealth = 6
        }
    }
}

struct SelectPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPlayerView().previewInterfaceOrientation(.landscapeRight)
    }
}

