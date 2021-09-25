//
//  LoadingView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/24/21.
//

import SwiftUI
import SFSafeSymbols
struct LoadingView: View {
    @State var animate = false
    @State var animate2 = false
    var body: some View {
        ZStack {
        LinearGradient.Secondary
            .ignoresSafeArea()
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeOut(duration: 2.0)) {
                    animate = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeOut(duration: 2.0)) {
                        animate2 = true
                        }
                    }
                }
            }
            VStack {
            if animate {
            Image(systemSymbol: .sleep)
                .foregroundColor(.white)
                .font(.custom("Poppins-Bold", size: 100, relativeTo: .headline))
                .transition(.opacity)
                .padding()
            }
            if animate2 {
            Text("RememBear")
                .foregroundColor(.white)
                .font(.custom("Poppins-Bold", size: 36, relativeTo: .headline))
                .transition(.opacity)
                .padding()
                
            }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
