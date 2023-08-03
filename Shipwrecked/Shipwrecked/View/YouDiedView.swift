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
                .scaleEffect(1.25)
            
            Text("YOU DIED")
                .font(CustomFont8Bit.title)
                .foregroundColor(.red)
            
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

/// WOULD BE A DIFFERENT VIEW

//struct YouWinView: View {
//    var body: some View {
//            ZStack {
//                Color.black.edgesIgnoringSafeArea(.all)
//
//                Image("Sun")
//                    .resizable()
//                    .scaledToFit()
//                    .scaleEffect(1.5)
//
//                Text("YOU ESCAPED HOORAY")
//                    .font(CustomFont8Bit.title)
//                    .foregroundColor(.white)
//
//                    NavigationLink {
//                        MenuView()
//                            .navigationBarBackButtonHidden(true)
//                    } label: {
//                        Text("PLAY AGAIN")
//                            .font(CustomFont8Bit.body)
//                            .foregroundColor(.white)
//                            .padding(.top, 300)
//                            .padding(.trailing, 500)
//            }
//        }
//    }
//}

struct YouDiedView_Previews: PreviewProvider {
    static var previews: some View {
        YouDiedView().previewInterfaceOrientation(.landscapeRight)
    }
}
