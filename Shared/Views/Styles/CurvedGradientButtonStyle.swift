//
//  CurvedGradientButtonStyle.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI

struct CurvedGradientButtonStyle: ButtonStyle {
    var button: ButtonData
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
            //.foregroundColor(Color(.))
            .padding()
           
            .background(button.type == .Gradient ? AnyView(button.gradient.cornerRadius(20)) : AnyView(RoundedRectangle(cornerRadius: 20).stroke(Color.Dark, lineWidth: 4)))
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            //.animation(.easeOut(duration: 0.2))
    }
}
