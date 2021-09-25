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
        ZStack {
            (button.type == .Gradient ? AnyView(button.gradient.cornerRadius(20)) : AnyView(RoundedRectangle(cornerRadius: 20).foregroundColor(.clear)))
            (button.type == .Gradient ? AnyView(button.gradient.cornerRadius(20)) : AnyView(RoundedRectangle(cornerRadius: 20).stroke(Color.Dark, lineWidth: 4)))
               
        configuration.label
            .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
            .foregroundColor(Color(.white))
            .padding()
           
           
           
            //.animation(.easeOut(duration: 0.2))
    }   .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .frame(height: 85)
            .padding()
        
    }
}
import SwiftUI

struct CurvedBorderButtonStyle: ButtonStyle {
    var button: ButtonData
    func makeBody(configuration: Configuration) -> some View {
        
        ZStack {
            (button.type == .Gradient ? AnyView(button.gradient.cornerRadius(20)) : AnyView(RoundedRectangle(cornerRadius: 20).foregroundColor(Color(UIColor.systemBackground))))
            (button.type == .Gradient ? AnyView(button.gradient.cornerRadius(20)) : AnyView(RoundedRectangle(cornerRadius: 20).stroke(Color.Dark, lineWidth: 4)))
                
        configuration.label
            .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
            //.foregroundColor(Color(.))
            .padding()
        
           
            //.animation(.easeOut(duration: 0.2))
        }  .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .frame(height: 85)
            .padding()
    }
}
