//
//  View.swift
//  Shipwrecked
//
//  Created by Forrest Arnold on 03/05/1402 AP.
//

import SwiftUI

/// FIRST SCREEN OR LOADING SCREEN

struct MenuView: View {
    
    @State var startGame = false
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                Image("beach")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.25)
                    .padding(.top, 25)
                
                ZStack {
                    Text("SHIPWRECKED")
                        .font(CustomFontBlock.title)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width, alignment: .bottom)
                        .shadow(radius: 5)
                        .padding(.top, 75)
                    
                    ZStack {
                        Button(action: {
                            startGame.toggle()
                        }, label: {
                            Text("start")
                                .font(CustomFontRetro.small)
                                .foregroundColor(.clear)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        })
                        
                    }
                }
            }
        }
        if startGame {
            SelectPlayerView()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
