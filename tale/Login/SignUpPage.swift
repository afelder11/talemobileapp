//
//  SignUpPage.swift
//  tale
//
//  Created by Austin Felder on 9/18/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

struct SignUpView : View {
    @State var email : String = ""
    @State var username : String = ""
    @State var password1 : String = ""
    @State var password2 : String = ""
    
    @Binding var isPresented : Bool
    @Binding var isLoggedIn : Bool
    
    init(isPresented : Binding<Bool>, isLoggedIn : Binding<Bool>) {
        _isPresented = isPresented
        _isLoggedIn = isLoggedIn
        UITableView.appearance().backgroundColor = .white
        UITableView.appearance().separatorColor = .clear
    }
    
    var body : some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Email", text: self.$email).frame(height: 50, alignment: .center)
                    TextField("Username", text: self.$username).frame(height: 50, alignment: .center)
                    SecureField("Password", text: self.$password1).frame(height: 50, alignment: .center)
                    SecureField("Password (Again)", text: self.$password2).frame(height: 50, alignment: .center)
                }
                
                Section {
                    Button(action: self.submit, label: {Text("Submit").bold().foregroundColor(.white).frame(minWidth: 0, maxWidth: .infinity, minHeight: 70, idealHeight: 50, maxHeight: 70, alignment: .center)}).background(Color.blue).cornerRadius(10).padding()
                    
                }
            }.navigationBarTitle("Sign Up")
        }
    }
    
    func submit() {
        self.isPresented.toggle()
        
        if password1 == password2 {
            Auth.auth().createUser(withEmail: self.email, password: self.password1) { (result, error) in
                if error == nil {
                    
                    
                    let user = UserObject()
                    user.id = result?.user.uid ?? ""
                    user.username = self.username
                    user.isLoggedIn.value = true
                    user.writeToRealm()
                    
                    let ref = Database.database().reference().child("users")
                    ref.child(user.id).updateChildValues(["uid" : user.id,
                                                          "username" : self.username])
                    
                    self.isLoggedIn = true
                    
                    
                } else {
                    print(error)
                }
            }
        }
    }
    
}

