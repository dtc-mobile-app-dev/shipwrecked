
//
//  SelectPlayerView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/1/23.
//

import SwiftUI

struct SelectPlayerView: View {
    
//    @EnvironmentObject var scene: GameScene
    
    @ObservedObject var scene:GameScene
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("select a character to continue")
                    .font(CustomFont8Bit.medium)
                    .foregroundColor(.white)
                    .padding(25)
                
                VStack {
                    
                    Text("select a character to continue")
                        .font(CustomFont8Bit.medium)
                        .foregroundColor(.white)
                        .padding(25)
                    
                    ZStack {
                        NavigationLink {
                            StoryView(scene: scene)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            HStack {
                                
                                Image("Bullet")
                                    .frame(width: 50, height: 50)
                                
                                Button {
                                    scene.currentPlayer = Player(character: "GunnerRight1", weapon: "gunner", heathPoints: 10)
                                } label: {
                                    Image("GunnerProfilePic")
                                        .resizable()
                                        .scaledToFill()
                                }
                                
                                Button {
                                    scene.currentPlayer = Player(character: "WelderRight1", weapon: "welder", heathPoints: 10)
                                } label: {
                                    Image("WelderProfilePic")
                                        .resizable()
                                        .scaledToFill()
                                }
                                
                                Button {
                                    scene.currentPlayer = Player(character: "KevinRight1", weapon: "kevin", heathPoints: 10)
                                } label: {
                                    Image("KevinProfilePic")
                                        .resizable()
                                        .scaledToFill()
                                }
                            }

                        }
                    }
                    .padding()
                    .shadow(color: .white.opacity(0.25), radius: 2.5)
                }
            }
        }
    }
}
