//
//  UIOverlay.swift
//  Shipwrecked
//
//  Created by Sam Johanson on 8/2/23.
//

import SwiftUI

struct UIOverlay: View {
    var body: some View {
        VStack{
            HStack {
                Image("HealthBar6MAX")
                Spacer()
                Image("BorderWithRedBackground")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .overlay{ Image("Gun").resizable().padding(5)}
                .padding(30)
                Image("BorderWithRedBackground")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .overlay{ Image("WelderProfilePic").resizable().padding(5)}
            }
            .padding(.top)
            Spacer()
        }
    }
}

struct UIOverlay_Previews: PreviewProvider {
    static var previews: some View {
        UIOverlay()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
