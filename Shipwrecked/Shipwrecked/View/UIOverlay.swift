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
                    .overlay{ Image("Gun")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(5)
                    }
                Image("InventoryIconNew")
                    .resizable()
                    .frame(width: 70, height: 70)
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
