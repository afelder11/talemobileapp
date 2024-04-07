//
//  PostingPage.swift
//  tale
//
//  Created by Austin Felder on 9/14/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI
import RealmSwift
import Firebase

struct PostingView : View {
    @State var description : String = ""
    @State var isPresented : Bool = false
    @State var image : Image?
    @State var uiImage : UIImage?
    @ObservedObject var dataHandler : DataHandler
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    if image != nil {
                        self.image!.resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 80, alignment: .center).clipped().cornerRadius(5)
                    }
                    
                    else {
                    
                        Image(systemName: "folder.circle.fill").aspectRatio(contentMode: .fill).frame(width: 80, height: 80, alignment: .center).clipped().background(Color.gray).cornerRadius(5)
                    }
                    Spacer()
                    Button(action: self.choosePhoto, label: {Text("Choose Photo")})
                    Spacer()
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("Description").font(.largeTitle).bold()
                    Text("Type your thoughts").font(.caption).foregroundColor(.gray)
                    MultilineTextView(text: self.$description).cornerRadius(5).frame(height: 100, alignment: .leading)
                }.padding()
                
                Spacer()
                Button(action: self.submit, label: {Text("Submit").bold().foregroundColor(.white).frame(minWidth: 0, maxWidth: .infinity, minHeight: 70, idealHeight: 50, maxHeight: 70, alignment: .center)}).background(Color.blue).cornerRadius(10
                ).padding()
            }
        }.sheet(isPresented: self.$isPresented, content: {
            ImagePicker(isShown: self.$isPresented, image: self.$image, uiImage: self.$uiImage)
        } )
    }
    
    func choosePhoto() {
        self.isPresented.toggle()
    }
    
    func submit() {
        
        print(uiImage?.size)
        guard let imageData = uiImage?.jpegData(compressionQuality: 0.1) else {return}
        let postId = UUID().uuidString
        let ref = Storage.storage().reference().child("posts").child(postId)
        ref.putData(imageData, metadata: nil) { (metadata, error) in
            if error == nil {
                ref.downloadURL { (url,error) in
                if error == nil {
                    let imageHeight = self.uiImage?.size.height ?? 0
                    let imageWidth = self.uiImage?.size.width ?? 0
                    let aspectRatio = Double(imageHeight / imageWidth)
                    
                    var searchTerms = [String : Bool]()
                    for word in self.description.components(separatedBy: " ") {
                        searchTerms[word.lowercased()] = true
                    }
                    searchTerms[self.description.lowercased()] = true
                    
                    Database.database().reference().child("posts").child(postId).updateChildValues(["imageUrl" : url?.absoluteString ?? "", "id" : postId, "comment" : self.description, "aspectRatio" : aspectRatio, "date": Date().iso8601, "searchTerms": searchTerms, "uid" : self.dataHandler.loggedInUser.id])
                }
                }
            } else {
                print(error)
            }
        }
    }
}

