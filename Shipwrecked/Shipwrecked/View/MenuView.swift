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
                ConstantsView.backgroundColorOne.edgesIgnoringSafeArea(.all)
                ConstantsView.backgroundColorTwo.edgesIgnoringSafeArea(.all)
                
                ConstantsView.menuImage
                    .resizable().scaledToFill().edgesIgnoringSafeArea(.all).padding(.top, 25)
                
                NavigationLink {
                    SelectPlayerView().navigationBarBackButtonHidden(true)
                } label: {
                    ConstantsView.menuTitle
                        .font(CustomFontBlock.title).kerning(5).foregroundColor(.black).shadow(color: .white, radius: 3.5)
                }
            }
            .onAppear { SoundManager.instance.playMusic(sound: .IslandTheme, volume: 0.5, loops: 5) }
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

struct ConstantsView {
    static let backgroundColorOne = Color.cyan.opacity(0.5)
    static let backgroundColorTwo = Color.white.opacity(0.1)
    static let menuTitle = Text("SHIPWRECKED")
    static let menuImage = Image("BeachForMenu")
    static let playerTitle = Text("SELECT A CHARACTER TO CONTINUE")
    static let playerImage = Image("BoatPiecesOnBeachWithTreesMenu")
    static let gunner = Image("GunnerProfilePic")
    static let welder = Image("WelderProfilePic")
    static let kevin = Image("KevinProfilePic")
    static let storyTitle = Text("You and your crewmates were sailing across the seven seas. One day, a vicious storm approached the boat with such might and destroyed the ship. You and the crew wash up on an island and are immediatley surrounded by the Native Boku Tribe. You are able to escape while the rest of the crew are captured. You must travel the island to find the rest of the crew and escape unharmed.")
    static let loadingTitle = Text("LOADING...")
    static let loadingImage = Image("LoadingBar")
    static let failTitle = Text("YOU DIED")
    static let failImage = Image("SkullDetailed")
    static let restart  = Text("RESTART")
    static let winTitle = Text("YOU SURVIVED")
    static let winImage = Image("PurpleSun")
}
