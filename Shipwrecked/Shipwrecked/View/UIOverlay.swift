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
                //            Image(name: "HeartHealthBar")
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 200, height: 20)
                    .foregroundColor(.red)
                Spacer()
                
                Image("BorderWithRedBackground")
                    .resizable()
                    .foregroundColor(.red)
                    .overlay{ Image("WelderProfilePic").resizable().padding(5)}
                .padding(30)
                //            Image(name: "border")
                //                .zIndex(0)
                //            Image(name: "inventory")
                //                .zIndex(1)
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
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
