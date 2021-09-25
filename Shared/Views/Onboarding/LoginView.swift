//
//  LoginView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/24/21.
//

import SwiftUI
import SFSafeSymbols
struct LoginView: View {
    @State var user = User(id: "", name: "", userName: "", email: "", password: "")
    var body: some View {
        VStack {
        Image(systemSymbol: .sleep)
            .foregroundColor(.Primary)
            .font(.custom("Poppins-Bold", size: 100, relativeTo: .headline))
        TextField("Username", text: $user.userName)
            .padding()
            .textFieldStyle(CurvedTextFieldStyle())
        
        TextField("Password", text: $user.password)
            .padding()
            .textFieldStyle(CurvedTextFieldStyle())
        Button(action: {
            
        }) {
            Text("Sign Up")
                .frame(width: 220)
        } .buttonStyle(CurvedGradientButtonStyle(button: ButtonData(id: UUID().uuidString, type: .Gradient, gradient: .Primary)))
                .padding(.vertical)
        Button(action: {
            
        }) {
            Text("Login")
                .frame(width: 220)
        }.buttonStyle(CurvedGradientButtonStyle(button: ButtonData(id: UUID().uuidString, type: .Outline, gradient: .Primary)))
                .padding(.vertical)
               
    }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
