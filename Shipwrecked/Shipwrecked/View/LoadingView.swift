//
//  LoadingView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/3/23.
//

import SwiftUI

struct LoadingView: View {
    
    var animate = false
    var body: some View {
        ZStack {
            Color.cyan.opacity(0.5).edgesIgnoringSafeArea(.all)
            Color.white.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            Image("LoadingBar")
                .resizable().scaledToFit().padding(.top, 150)
                .shadow(color: .white.opacity(0.25), radius: 2.5)
                .animation(.easeInOut(duration: 2.5).repeatForever(), value: animate)
            
            NavigationLink {
                GameView().navigationBarBackButtonHidden(true)
            } label: {
                Text("LOADING...")
                    .font(CustomFontBlock.title).foregroundColor(.black).shadow(color: .white, radius: 2.5).padding(.bottom, 125).kerning(1.5)
                    .animation(.easeInOut(duration: 5).repeatForever(), value: animate)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView().previewInterfaceOrientation(.landscapeRight)
    }
}
