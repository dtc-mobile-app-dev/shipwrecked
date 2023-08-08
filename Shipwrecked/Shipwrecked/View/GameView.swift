//
//  ContentView.swift
//  DEMO TilemapGame
//
//  Created by Asher McConnell on 7/25/23.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    
    @ObservedObject var scene: GameScene
    @State var location: CGPoint = .zero
    @State var innerCircleLocation: CGPoint = .zero
    
    @GestureState var fingerLocation: CGPoint? = nil
    @GestureState var startLocation: CGPoint? = nil
    
    @State var score = 0
    @State var angle = 0
    
    let bigCircleRadius: CGFloat = 100
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
            
            rightstick
                .position(x:Constants.controllerPositionX, y: Constants.controllerPositionY)

                .overlay {
                    UIOverlay()
                }
            VStack {
                Spacer()
                Text(angleText)
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .cornerRadius(10)
            }
        }
    }
}

extension GameView {
    
    // MARK: - CONSTANTS
    
    private struct Constants {
        static let controllerPositionX: CGFloat = 1000
        static let controllerPositionY: CGFloat = 350
    }
    
    // MARK: - CONTROLLER VIEW
    
    var rightstick: some View {
        ZStack {
            Circle()
                .foregroundColor(.black.opacity(0.25))
                .frame(width: bigCircleRadius * 2, height: bigCircleRadius * 1.5)
                .position(location)
            
            Circle()
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                .position(innerCircleLocation)
                .gesture(fingerDrag)
        }
        .frame(alignment: .center)
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                
                let distance = sqrt(pow(newLocation.x - location.x, 2) + pow(newLocation.y - location.y, 2))
                
                if distance > bigCircleRadius {
                    let angle = atan2(newLocation.y - location.y, newLocation.x - location.x)
                    newLocation.x = location.x + cos(angle) * bigCircleRadius
                    newLocation.y = location.y + sin(angle) * bigCircleRadius
                }
                
                self.location = newLocation
                self.innerCircleLocation = newLocation
            }
            .updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }
    }
    
    var fingerDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                let distance = sqrt(pow(value.location.x - location.x, 2) + pow(value.location.y - location.y, 2))
                let angle = atan2(value.location.y - location.y, value.location.x - location.x)
                let maxDistance = bigCircleRadius
                let clampedDistance = min(distance, maxDistance)
                let newX = location.x + cos(angle) * clampedDistance
                let newY = location.y + sin(angle) * clampedDistance
                
                innerCircleLocation = CGPoint(x: newX, y: newY)
            }
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
            .onEnded { value in
                let center = location
                innerCircleLocation = center
            }
    }
    
    var angleText: String {
        let angle = atan2(innerCircleLocation.y - location.y, innerCircleLocation.x - location.x)
        var degrees = Int(-angle * 180 / .pi)
        
        if degrees < 0 {
            degrees += 360
        }
        
        var isAttacking = false
        
        if fingerLocation == nil {
            isAttacking = false
        } else {
            isAttacking = true
        }
        
        scene.updateAngle(degrees: degrees, isAttacking: isAttacking)
        
        return "\(degrees)°"
    }
}

