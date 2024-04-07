//
//  ProfilePage.swift
//  tale
//
//  Created by Austin Felder on 9/14/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI

struct ProfileView : View {
    @ObservedObject var dataHandler : DataHandler
    @Binding var isLoggedIn : Bool
    @Environment(\.imageCache) var cache : ImageCache
    
    var currentUser : UserObject
    
    var body : some View {
        NavigationView {
            if currentUser == dataHandler.loggedInUser {
                VStack {
                    ProfileViewHeader(currentUser: currentUser, dataHandler: self.dataHandler)
                    QGrid(self.dataHandler.profilePagePosts, columns: 3, columnsInLandscape: nil, vSpacing: 1, hSpacing: 0, vPadding: 0, hPadding: 0, isScrollable: true, showScrollIndicators: false, content: {
                        post in
                        
                        
                        NavigationLink(
                            destination: SinglePostView(currentPost: post.post),
                            label: {
                                AsyncImage(url : URL(string: post.post.imageURL)!, placeholder : {Text ("loading ")},image:{Image(uiImage : $0).resizable()}).aspectRatio(contentMode: .fill).frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3, alignment: .center).clipped()
                                
                            }).buttonStyle(PlainButtonStyle())
                        
                    })
     
                }.navigationBarItems(trailing: NavigationLink(destination: SettingsView(dataHandler: self.dataHandler, isLoggedIn: self.$isLoggedIn) , label: {
                    Image(systemName: "slider.horizontal.3")
                }).accentColor(.black)).navigationBarTitle("Profile", displayMode: .inline)
            }else {
                VStack {
                    ProfileViewHeader(currentUser: currentUser, dataHandler: self.dataHandler)
                    QGrid(self.dataHandler.temporaryPosts, columns: 3, columnsInLandscape: nil, vSpacing: 1, hSpacing: 0, vPadding: 0, hPadding: 0, isScrollable: true, showScrollIndicators: false, content: {
                        post in
                        
                        
                        NavigationLink(
                            destination: SinglePostView(currentPost: post.post),
                            label: {
                                AsyncImage(url : URL(string: post.post.imageURL)!, placeholder : {Text ("loading ")},image:{Image(uiImage : $0).resizable()}).aspectRatio(contentMode: .fill).frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3, alignment: .center).clipped()
                                
                            }).buttonStyle(PlainButtonStyle())
                        
                    })                }
                }
                
        }.onAppear() {
            self.dataHandler.loadPostsFor(currentUser.id)
        }
           
                    
            }
        }
    
    

