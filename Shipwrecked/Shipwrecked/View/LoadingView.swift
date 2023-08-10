//
//  LoadingView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/3/23.
//

import SwiftUI

struct LoadingView: View {
    
    @StateObject var scene = GameScene()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            Image("LoadingBar")
                .resizable()
                .padding(.top, 200)
            
                    NavigationLink {
                        GameView(scene: scene)
                            .navigationBarBackButtonHidden(true)
                        
                    } label: {
                        Text("LOADING...")
                            .font(CustomFont8Bit.large)
                            .foregroundColor(.white)
                            .padding(.bottom, 125)
                        
                    }
               
        }
    }
}
//
//struct LoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingView(scene: GameScene()).previewInterfaceOrientation(.landscapeRight)
//    }
//}
