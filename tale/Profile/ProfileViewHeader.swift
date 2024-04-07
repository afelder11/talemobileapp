//
//  ProfileViewHeader.swift
//  tale
//
//  Created by Austin Felder on 9/18/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI

struct ProfileViewHeader : View {
    var currentUser : UserObject
    @ObservedObject var dataHandler : DataHandler
    @Environment(\.imageCache) var cache : ImageCache

    var body: some View {
        HStack {
            VStack {
                if currentUser.profileImageURL != "" {
                    AsyncImage(url : URL(string: currentUser.profileImageURL)!, placeholder : {Text ("loading ")},image:{Image(uiImage : $0).resizable()}).frame(width: 80, height: 80, alignment: .center).cornerRadius(40)
                } else {
                    Color.init(red: 0.9, green: 0.9, blue: 0.9).frame(width: 80, height: 80, alignment: .center).cornerRadius(40)
                }
                Text(currentUser.username).font(.footnote)
            }
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Text("Followers").font(.callout)
                        Text("\(currentUser.followers.count)").font(.caption).bold()
                    }
                    Spacer()
                    VStack {
                        Text("Following").font(.callout)
                        Text("\(currentUser.followings.count)").font(.caption).bold()
                    }
                    Spacer()
                }
                if currentUser != self.dataHandler.loggedInUser {
                    Button(action: self.follow, label: {
                        ZStack {
                            Color.blue.frame(width: 100, height: 30, alignment: .center).cornerRadius(15)
                            Text((currentUser.isFollowing.value ?? false) ? "Following" : "Follow").bold().font(.callout).foregroundColor(.white)
                        }
                    })
                }
            }
                
            
        } .padding()
    }
    
    func follow() {
        
    }
}


