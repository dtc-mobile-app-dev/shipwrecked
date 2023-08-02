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
                
                Image("ScarySign")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.75)
                    .padding(.bottom)
                    .shadow(color: .black, radius: 25)
                
                Text("YOU DIED")
                    .font(CustomFontBlock.title)
                    .foregroundColor(.white)
                
                    NavigationLink {
                        MenuView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("RESTART")
                            .font(CustomFontBlock.small)
                            .foregroundColor(.white)
                            .padding(.top, 300)
                            .padding(.leading, 500)
               
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
