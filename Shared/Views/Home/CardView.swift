//
//  CardView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var userData: LoginManager
   
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.Card)
            HStack {
                Text("")
                    .font(.custom("Poppins-Bold", size: 100, relativeTo: .headline))
                CircularProgressView()
            }
        }
    }
}

