//
//  StoryView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/1/23.
//

import SwiftUI

struct StoryView: View {
    
    @ObservedObject var scene: GameScene
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            NavigationLink {
                LoadingView(scene: scene)
//                GameView(scene: scene)
                    .navigationBarBackButtonHidden(true)
                
            } label: {
                Text("You and your crewmates were sailing across the seven seas. One day, a vicious storm approached the boat with such might and destroyed the ship. You and the crew wash up on an island and are immediatley surrounded by the Native Boku Tribe. You are able to escape while the rest of the crew are captured. You must travel the island to find the rest of the crew and escape unharmed.")
                    .font(CustomFont8Bit.body)
                    .foregroundColor(.white)
                    .padding()
            }
        }
//        .onDisappear {
//            scene.isLoading = true
//        }
    }
}

//struct StoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoryView().previewInterfaceOrientation(.landscapeRight)
//    }
//}
