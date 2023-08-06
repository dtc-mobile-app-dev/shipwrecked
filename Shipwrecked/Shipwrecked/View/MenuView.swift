//
//  View.swift
//  Shipwrecked
//
//  Created by Forrest Arnold on 03/05/1402 AP.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                Image("Beach")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.25)
                    .padding(.top, 25)
                
                NavigationLink {
                    SelectPlayerView()
                        .navigationBarBackButtonHidden(true)
                    
                } label: {
                    Text("SHIPWRECKED")
                        .font(CustomFont8Bit.large)
                        .kerning(2.5)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width, alignment: .bottom)
                        .padding(.top, 50)
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
