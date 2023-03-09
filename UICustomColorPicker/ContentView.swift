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
            if let startLocation {
                Circle()
                    .frame(width: diameter)
                    .position(startLocation)

                /// Handle
                Circle()
                    .frame(width: 50)
                    .position(startLocation)
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
                }

                location = value.location
            }
            .onEnded { value in
                startLocation = nil
                location = nil
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
