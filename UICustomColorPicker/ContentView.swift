//
//  ContentView.swift
//  UICustomColorPicker
//
//  Created by Luiz Araujo on 09/03/23.
//

import SwiftUI

struct ContentView: View {

    let radius: CGFloat = 100
    var diameter: CGFloat {
        radius * 2
    }

    var body: some View {
        ZStack {
            Circle()
                .frame(width: diameter)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
