//
//  View.swift
//  Shipwrecked
//
//  Created by Forrest Arnold on 03/05/1402 AP.
//

import SwiftUI

/// FIRST SCREEN OR LOADING SCREEN

struct MenuView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                Image("beach")
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
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width, alignment: .bottom)
                        .padding(.top, 75)
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
