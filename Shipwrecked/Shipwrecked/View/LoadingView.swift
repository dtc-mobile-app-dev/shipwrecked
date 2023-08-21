//
//  LoadingView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/3/23.
//

import SwiftUI

struct LoadingView: View {
    
    @State var startLoading = false
    
    var body: some View {
        ZStack {
            ConstantsView.backgroundColorOne.edgesIgnoringSafeArea(.all)
            ConstantsView.backgroundColorTwo.edgesIgnoringSafeArea(.all)
            
            ConstantsView.loadingImage
                .resizable().scaledToFit().padding(.top, 150).shadow(color: .white.opacity(0.25), radius: 2.5).frame(width: 500, height: 750, alignment: .center)
            
            Button {
                self.startLoading.toggle()
            } label: {
                ConstantsView.loadingTitle
                    .font(CustomFontBlock.title).foregroundColor(.black).shadow(color: .white, radius: 3.5).padding(.bottom, 50).kerning(3.5)
            }
            .background(
                NavigationLink(destination: GameView(currentSelectedItem: InventoryItem(name: "Cutlass", imageName: "Cutlass", itemDescription: "Bendy sword", isWeapon: true, isFood: false, isRanged: false, isMelee: true)).navigationBarBackButtonHidden(true), isActive: $startLoading) { }
            )
            .onAppear { self.startLoading.toggle() }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView().previewInterfaceOrientation(.landscapeRight)
    }
}
