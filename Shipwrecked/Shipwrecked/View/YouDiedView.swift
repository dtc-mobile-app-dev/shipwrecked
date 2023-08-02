//
//  YouDiedView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/2/23.
//

import SwiftUI

struct YouDiedView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                Text("GAME OVER")
                    .font(CustomFontBlock.title)
                    .foregroundColor(.white)
                
                    NavigationLink {
                        SelectPlayerView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("RESTART")
                            .font(CustomFontRetro.small)
                            .foregroundColor(.white)
                            .padding(.top, 250)
               
                }
            }
        }
    }
}

struct YouDiedView_Previews: PreviewProvider {
    static var previews: some View {
        YouDiedView().previewInterfaceOrientation(.landscapeRight)
    }
}
