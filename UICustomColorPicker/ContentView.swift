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
    @State private var bgColor: Color = .green

    let radius: CGFloat = 150
    var diameter: CGFloat {
        radius * 2
    }

    var body: some View {
        ZStack {
            if startLocation != nil && location != nil {
                Circle()
                    .fill(
                        AngularGradient(gradient: Gradient(colors: [
                            Color(hue: 1.0, saturation: 1, brightness: 0.9),
                            Color(hue: 0.9, saturation: 1, brightness: 0.9),
                            Color(hue: 0.8, saturation: 1, brightness: 0.9),
                            Color(hue: 0.7, saturation: 1, brightness: 0.9),
                            Color(hue: 0.6, saturation: 1, brightness: 0.9),
                            Color(hue: 0.5, saturation: 1, brightness: 0.9),
                            Color(hue: 0.4, saturation: 1, brightness: 0.9),
                            Color(hue: 0.3, saturation: 1, brightness: 0.9),
                            Color(hue: 0.2, saturation: 1, brightness: 0.9),
                            Color(hue: 0.1, saturation: 1, brightness: 0.9),
                            Color(hue: 0.0, saturation: 1, brightness: 0.9)

                        ]), center: .center)
                    )
                    .frame(width: diameter)
                    .overlay {
                        Circle()
                            .fill(
                                RadialGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0.000000001)]),
                                               center: .center, startRadius: 0, endRadius: radius)
                            )
                    }
                    .position(startLocation!)
                    .shadow(color: .black.opacity(0.1), radius: 6, y: 8)

                /// Handle
                Circle()
                    .frame(width: 50)
                    .position(location!)
//                    .foregroundColor(Color.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(bgColor)
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

                    // Calculate the current color value
                    guard distance != 0 else { return }

                    var angle = Angle(radians: -Double(atan(dir.y / dir.x)))
                    if dir.x < 0 {
                        angle.degrees += 180

                    } else if dir.x > 0 && dir.y > 0 {
                        angle.degrees += 360
                    }
//                    print("Degrees: ", angle.degrees)

                    let hue = angle.degrees / 360
                    let saturation = Double(distance / radius)
                    bgColor = Color(hue: hue, saturation: saturation, brightness: 0.7)
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
