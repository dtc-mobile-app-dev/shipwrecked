//
//  YouDiedView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/2/23.
//

import SwiftUI

struct YouDiedView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            Image("SkullDetailed")
                .resizable().scaledToFit().scaleEffect(1.15).shadow(color: .red, radius: 10)
            
            Text("YOU DIED")
                .font(CustomFontBlock.mediumLarge).kerning(10).foregroundColor(.red).shadow(color: .black, radius: 2.5)
            
            NavigationLink {
                MenuView().navigationBarBackButtonHidden(true)
            } label: {
                Text("RESTART")
                    .font(CustomFontBlock.small).foregroundColor(.white)
                    .padding(.top, 325).padding(.leading, 525).shadow(color: .red, radius: 1.5).kerning(1.5)
            }
        }
    }
}

struct YouDiedView_Previews: PreviewProvider {
    static var previews: some View {
        YouDiedView().previewInterfaceOrientation(.landscapeRight)
    }
}
