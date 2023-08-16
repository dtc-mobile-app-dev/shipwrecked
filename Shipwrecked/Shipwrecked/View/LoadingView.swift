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
            Color.cyan.opacity(0.5).edgesIgnoringSafeArea(.all)
            Color.white.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            Image("LoadingBar")
                .resizable().scaledToFit().padding(.top, 150).shadow(color: .white.opacity(0.25), radius: 2.5).padding(.leading, 75)
            
            Button {
                self.startLoading.toggle()
            } label: {
                Text("LOADING...")
                    .font(CustomFontBlock.title).foregroundColor(.black).shadow(color: .white, radius: 3.5).padding(.bottom, 100).kerning(3.5)
            }
            .background(
                NavigationLink(destination: GameView(currentSelectedItem: InventoryItem(name: "Cutlass", imageName: "Cutlass", itemDescription: "Bendy sword", isWeapon: true, isFood: false)).navigationBarBackButtonHidden(true), isActive: $startLoading) { }
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
