//
//  TabViewController.swift
//  tale
//
//  Created by Austin Felder on 9/18/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI

struct TabViewController : View {
    @ObservedObject var dataHandler : DataHandler
    @Binding var isLoggedIn : Bool 
    var body: some View {
        TabView {
            HomeView(dataHandler: dataHandler).tabItem({Image(systemName: "house.fill")})
            ExploreView(dataHandler: dataHandler).tabItem({Image(systemName: "bolt.circle.fill")})
            PostingView(dataHandler: dataHandler).tabItem({Image(systemName: "arrowtriangle.up.circle.fill")})
            NotificationView(dataHandler: dataHandler).tabItem({Image(systemName: "tray.fill")})
            ProfileView(dataHandler: dataHandler, isLoggedIn: self.$isLoggedIn, currentUser: self.dataHandler.loggedInUser).tabItem { Image(systemName: "person.circle.fill") }
        }.accentColor(.black)
    }
}


