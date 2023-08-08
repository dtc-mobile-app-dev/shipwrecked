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
            
            Image("Skull")
                .resizable()
                .scaledToFit()
                .scaleEffect(1.15)
                .shadow(color: .red, radius: 50)
            
            Text("YOU DIED")
                .font(CustomFont8Bit.title)
                .kerning(5)
                .foregroundColor(.red)
                .shadow(color: .black, radius: 5)
            
            NavigationLink {
                MenuView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("RESTART")
                    .font(CustomFont8Bit.body)
                    .foregroundColor(.white)
                    .padding(.top, 325)
                    .padding(.leading, 525)
            }
        }
    }
}

struct YouDiedView_Previews: PreviewProvider {
    static var previews: some View {
        YouDiedView().previewInterfaceOrientation(.landscapeRight)
    }
}
