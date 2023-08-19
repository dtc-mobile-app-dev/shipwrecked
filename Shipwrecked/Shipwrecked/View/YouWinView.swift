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
            
            Constants.winImage
                .resizable().scaledToFit().scaleEffect(1.35).padding(.top)
            
            Constants.winTitle
                .font(CustomFontBlock.title).foregroundColor(.white)
                .shadow(color: .pink, radius: 2.5).padding(.bottom, 150)
        }
    }
}

struct YouWinView_Previews: PreviewProvider {
    static var previews: some View {
        YouWinView().previewInterfaceOrientation(.landscapeRight)
    }
}
