//
//  ContentView.swift
//  UICustomColorPicker
//
//  Created by Luiz Araujo on 09/03/23.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let imgColor: Color

    static let items = [
        Item(title: "Home", image: "house.fill", imgColor: .orange),
        Item(title: "Money", image: "dollarsign", imgColor: .green),
        Item(title: "Bank", image: "lock.shield.fill", imgColor: .black.opacity(0.8)),
        Item(title: "Vacation", image: "airplane.departure", imgColor: .purple),
        Item(title: "User", image: "person.fill", imgColor: .blue),
        Item(title: "Charts", image: "chart.pie.fill", imgColor: .pink),
        Item(title: "Support", image: "phone.and.waveform.fill", imgColor: .cyan)
    ]
}

struct ContentView: View {
    @State private var numberOfColumns = 4
    let items = Item.items

    private let spacing = CGFloat(10)

    var body: some View {

        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)

        ScrollView {
            // MARK: Header
            headerView

            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(items) { item in
                    Button { } label: {
                        ItemView(item: item)
                    }
                    .buttonStyle(ItemButtonStyle(cornerRadius: 20))
                }
            }
            .padding(.horizontal)
            .offset(y: -50)
        }
        .background(.white)
        .ignoresSafeArea()
        .animation(.easeInOut, value: numberOfColumns)
    }

    var headerView: some View {
        VStack {
            Image("avatar")
                .resizable()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .onTapGesture {
                    numberOfColumns = numberOfColumns % 4 + 1
                }

            Text("Franklin Benjamin")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .medium, design: .rounded))

            Text("Change the world by being yourself.")
                .foregroundColor(.white.opacity(0.8))
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .multilineTextAlignment(.center)
        }
        .frame(height: 350)
        .frame(maxWidth: .infinity)
        .background(.purple)
    }
}

struct ItemButtonStyle: ButtonStyle {
    let cornerRadius: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label

            if configuration.isPressed {
                Color.purple.opacity(0.2)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
    }
}

struct ItemView: View {
    let item: Item

    var body: some View {
        GeometryReader { reader in
            ///Make this View more dynamic.
            let fontSize = min(reader.size.width * 0.2, 28)
            let imageWidth: CGFloat = min(50, reader.size.width * 0.6)

            VStack(spacing: 5) {
                Image(item.image)
                    .scaledToFit()
                //                    .foregroundColor()
                    .frame(width: imageWidth)
                    .colorMultiply(item.imgColor)

                Text(item.title)
                    .font(.system(size: fontSize, weight: .bold, design: .rounded))
                    .foregroundColor(.black.opacity(0.9))
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(.white)
        }
        .frame(height: 150)
//        .clipShape(RoundedRectangle(cornerRadius: 20))
//        .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
