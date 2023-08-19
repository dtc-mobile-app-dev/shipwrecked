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
            
            Constants.failImage
                .resizable().scaledToFit().scaleEffect(1.15).shadow(color: .red, radius: 10)
            
            Constants.failTitle
                .font(CustomFontBlock.mediumLarge).kerning(10).foregroundColor(.red).shadow(color: .black, radius: 3.5)
            
            NavigationLink {
                MenuView().navigationBarBackButtonHidden(true)
            } label: {
                Constants.restart
                    .font(CustomFontBlock.small).foregroundColor(.white).padding(.top, 325).padding(.leading, 525).shadow(color: .red, radius: 1.5).kerning(1.5)
            }
        }
    }
}

struct YouDiedView_Previews: PreviewProvider {
    static var previews: some View {
        YouDiedView().previewInterfaceOrientation(.landscapeRight)
    }
}
