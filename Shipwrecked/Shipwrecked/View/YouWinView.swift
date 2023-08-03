//
//  YouWinView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/3/23.
//

import SwiftUI

struct YouWinView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            Image("Sun")
                .resizable()
                .scaledToFit()
                .scaleEffect(1.5)
            
            Text("YOU SURVIVED")
                .font(CustomFont8Bit.large)
                .foregroundColor(.white)
                .padding(.bottom, 100)
            
            NavigationLink {
                MenuView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("PLAY AGAIN")
                    .font(CustomFont8Bit.body)
                    .foregroundColor(.white)
                    .padding(.top, 300)
                    .padding(.trailing, 500)
            }
        }
    }
}

struct YouWinView_Previews: PreviewProvider {
    static var previews: some View {
        YouWinView().previewInterfaceOrientation(.landscapeRight)
    }
}
