//
//  CurvedTextFieldStyle.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/24/21.
//

import SwiftUI

struct CurvedTextFieldStyle: TextFieldStyle {

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundColor(.Dark)
            .padding(30)
            .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.Dark, lineWidth: 4)
                )
            .cornerRadius(20)
            
    }
}
