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
                .resizable().scaledToFit().scaleEffect(1.35).padding(.top)
            
            Text("YOU SURVIVED")
                .font(CustomFontBlock.title).foregroundColor(.white)
                .shadow(color: .pink, radius: 2.5).padding(.bottom, 150)
            
            NavigationLink {
                MenuView().navigationBarBackButtonHidden(true)
            } label: {
                Text("PLAY AGAIN")
                    .font(CustomFontBlock.small).foregroundColor(.white).padding(.top, 300)
                    .padding(.trailing, 500).shadow(color: .pink.opacity(0.75), radius: 1.5)
            }
        }
    }
}

struct YouWinView_Previews: PreviewProvider {
    static var previews: some View {
        YouWinView().previewInterfaceOrientation(.landscapeRight)
    }
}
