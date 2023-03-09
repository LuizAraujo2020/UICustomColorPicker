//
//  ContentView.swift
//  UICustomColorPicker
//
//  Created by Luiz Araujo on 09/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var startLocation: CGPoint?
    @State private var location: CGPoint?

    let radius: CGFloat = 100
    var diameter: CGFloat {
        radius * 2
    }

    var body: some View {
        ZStack {
            if startLocation != nil && location != nil {
                Circle()
                    .frame(width: diameter)
                    .position(startLocation!)

                /// Handle
                Circle()
                    .frame(width: 50)
                    .position(location!)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
        .gesture(dragGesture)
        .ignoresSafeArea()
    }

    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                if startLocation == nil {
                    startLocation = value.location

                } else {

                    // Clamp the location from handle so that it cannot move outside the color picker.
                    let distanceX = value.location.x - startLocation!.x
                    let distanceY = value.location.y - startLocation!.y

                    let dir = CGPoint(x: distanceX, y: distanceY)
                    var distance = sqrt(distanceX * distanceX + distanceY * distanceY)

                    if distance < radius {
                        location = value.location

                    } else {
                        let clampedX = dir.x / distance * radius
                        let clampedY = dir.y / distance * radius

                        location = CGPoint(x: startLocation!.x + clampedX,
                                           y: startLocation!.y + clampedY)

                        distance = radius
                    }
                }
            }
            .onEnded { value in
                startLocation = nil
                location      = nil
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
