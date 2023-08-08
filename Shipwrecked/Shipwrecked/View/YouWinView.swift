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
            
            Image("PurpleSun")
                .resizable()
                .scaledToFit()
                .scaleEffect(1.5)
            
            Text("YOU SURVIVED")
                .font(CustomFontBlock.title)
                .foregroundColor(.white)
                .shadow(color: .white, radius: 1.5)
                .padding(.bottom, 175)
            
            NavigationLink {
                MenuView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("PLAY AGAIN")
                    .font(CustomFontBlock.small)
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
