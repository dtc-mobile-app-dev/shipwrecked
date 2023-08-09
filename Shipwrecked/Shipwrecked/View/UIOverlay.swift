//
//  UIOverlay.swift
//  Shipwrecked
//
//  Created by Sam Johanson on 8/2/23.
//

import SwiftUI
import SpriteKit

struct UIOverlay: View {
    
    //    var signMessage: SKLabelNode!
    //    var message: String = "" {
    //        didSet {
    //            signMessage.text = "MESSAGE"
    //        }
    //    }
    
    @State var isAHint = false
    @State var isASign = false {
        didSet { isAHint.toggle() }
    }
    
    
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            
//            signBeach1
//            signBeach2
//            signBeach3
            
            HStack(spacing: 500) {
                Image("HealthBar6MAX")
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .white, radius: 25)
                
                NavigationLink {
                    
                    /// Will go to Inventory View like sheet or a popup
                    
                } label: {
                    Image("ORANGEBOX")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .shadow(color: .white, radius: 25)
                        .overlay {
                            Image("InventoryIcon")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .shadow(color: .white, radius: 5)
                                .padding(.bottom, 5)
                        }
                }
            }
            .padding(.bottom, 275)
        }
    }
}

struct UIOverlay_Previews: PreviewProvider {
    static var previews: some View {
        UIOverlay()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

// MARK: - EXTENSION

extension UIOverlay {
    
    //    func displaySignMessage(withTitle title: String, message: String) {
    //        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //
    //                let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
    //                alertController.addAction(okAction)
    //    }
    
    
    
    //    func displayMessage(tite: String, message: String) {
    //        let alertController = UIAlertController(title: "HINT", message: "testing", preferredStyle: .actionSheet)
    //
    //        let cancelAction = UIAlertAction(title: "message", style: .cancel, handler: nil)
    //
    //        alertController.addAction(cancelAction)
    //
    //        alertController.present(alertController, animated: true, completion: nil)
    //    }
    
    
    
    //    func createSignBorderNode(radius: CGFloat) -> SKShapeNode {
    //        let node = SKShapeNode(fileNamed: "SIGN 1")
    //        return node!
    //    }
    
    
    
    func createSignLabel(text: String) -> SKLabelNode {
        let node = SKLabelNode(text: text)
        node.verticalAlignmentMode = .center
        
        return node
    }
    
    
    var signBeach1: some View {
        ZStack {
            Image("SIGN 1")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 50)
                .overlay {
                    Text("Text for BEACH clue #1")
                        .font(CustomFontBlock.small)
                }
        }
    }
    
    
    var signBeach2: some View {
        ZStack {
            Image("BlankPaper")
                .resizable()
                .frame(width: 500, height: 300)
                .padding(.top, 25)
                .overlay {
                    Text("Text For BEACH clue #2")
                        .font(CustomFontBlock.small)
                }
        }
    }
    
    var signBeach3: some View {
        ZStack {
            Image("Paper1")
                .resizable()
                .frame(width: 600, height: 300)
                .padding(.top, 50)
                .overlay {
                    Text("Text for BEACH clue #3")
                        .font(CustomFontBlock.small)
                }
        }
    }
    
}
