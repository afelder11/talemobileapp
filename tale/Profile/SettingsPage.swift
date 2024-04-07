//
//  SettingsPage.swift
//  tale
//
//  Created by Austin Felder on 9/14/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import RealmSwift

struct SettingsView : View {
    
    @ObservedObject var dataHandler : DataHandler
    @State var isPresented : Bool = false
    @State var image : Image?
    @State var uiImage : UIImage?
    @State var username : String = ""
    @Binding var isLoggedIn : Bool
    
    var body: some View {
        VStack {
            HStack {
                if image != nil {
                    self.image!.resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 80, alignment: .center).clipped().cornerRadius(40)
                }
                
                else {
                
                    Image(systemName: "folder.circle.fill").aspectRatio(contentMode: .fill).frame(width: 80, height: 80, alignment: .center).clipped().background(Color.gray).cornerRadius(40)
                }
                Spacer()
                Button(action: self.choosePhoto, label: {Text("Choose Photo")})
                Spacer()
            }.padding()
            
            TextField("Username", text: self.$username, onEditingChanged : {
                changed in
            }, onCommit: {
                self.submitNewUsername()
            }).padding()
            
            Button(action: self.submit, label: {Text("Submit").bold().foregroundColor(.white).frame(minWidth: 0, maxWidth: .infinity, minHeight: 70, idealHeight: 50, maxHeight: 70, alignment: .center)}).background(Color.blue).cornerRadius(10).padding()
            Spacer()
            
            Button(action: self.logOut, label: {Text("Logout").bold().foregroundColor(.white).frame(minWidth: 0, maxWidth: .infinity, minHeight: 70, idealHeight: 50, maxHeight: 70, alignment: .center)}).background(Color.red).cornerRadius(10).padding()
            
        }.sheet(isPresented: self.$isPresented, content: {
            ImagePicker(isShown: self.$isPresented, image: self.$image, uiImage: self.$uiImage)
        })
    }
    
    func submitNewUsername() {
        if username == "" {
            
        }
        
        else {
            
        }
    }
    
    func submit() {
        guard let imageData = uiImage?.jpegData(compressionQuality: 0.1) else {return}
        
        let ref = Storage.storage().reference().child("users").child(self.dataHandler.loggedInUser.id)
        ref.putData(imageData, metadata: nil) { (metadata, error) in
            if error == nil {
                ref.downloadURL { (url,error) in
                if error == nil {
                   
                   
                    
                    Database.database().reference().child("users").child(self.dataHandler.loggedInUser.id).updateChildValues(["profileImage" : url?.absoluteString ?? ""])
                    self.dataHandler.loggedInUser.profileImageURL = url?.absoluteString ?? ""
                }
                }
            } else {
                print(error)
            }
        }
    }
    
    func logOut() {
       // try! uiRealm.write({
            self.isLoggedIn = false
            try! Auth.auth().signOut()
             
                uiRealm.deleteAll()
                //error: object has been deleted or invalidated
                //from deleteAll()
       // })
    }
    
    func choosePhoto() {
        self.isPresented.toggle()
    }
}

