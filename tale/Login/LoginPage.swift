//
//  LoginPage.swift
//  tale
//
//  Created by Austin Felder on 9/18/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

struct LoginView : View {
    @State var email = String()
    @State var password = String()
    @State var isPresented : Bool = false
    @Binding var isLoggedIn : Bool
    
    var body : some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .leading, endPoint: .trailing).frame( height: 200, alignment: .top).edgesIgnoringSafeArea(.top).shadow(radius: 10)
                Text("tale").foregroundColor(.white).bold().font(.largeTitle).padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                }
            TextField("Email", text: self.$email).padding()
            SecureField("Password", text: self.$password).padding()
            Button(action: self.logIn, label: {Text("Submit").bold().foregroundColor(.white).frame(minWidth: 0, maxWidth: .infinity, minHeight: 70, idealHeight: 50, maxHeight: 70, alignment: .center)}).background(Color.blue).cornerRadius(10).padding()
            HStack {
                Text("Don't have an account? ")
                Button(action: self.signUp , label:  {
                    Text("Sign Up Now.")
                })
            }
            Spacer()
        }.sheet(isPresented: self.$isPresented, content: {
            SignUpView(isPresented: self.$isPresented, isLoggedIn : self.$isLoggedIn)
        })
    }
    
    func logIn() {
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
            //try! uiRealm.write {
                if error == nil {
                    let user = UserObject()
                    user.id = result?.user.uid ?? ""
                    user.isLoggedIn.value = true
                    user.writeToRealm()
                    self.isLoggedIn = true
                } else {
                    print(error)
                }
            //}
        }
    }
    
    func signUp() {
        self.isPresented.toggle()
    }
}


