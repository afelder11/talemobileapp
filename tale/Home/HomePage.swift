//
//  HomePage.swift
//  tale
//
//  Created by Austin Felder on 9/14/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeView : View {
    @ObservedObject var dataHandler : DataHandler
    var body: some View {
        NavigationView {
            List {
                ForEach(self.dataHandler.homePagePosts, id: \.id, content: {
                    post in
                    PostCell(currentPost: post).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                })
            }.navigationBarTitle("Tale",displayMode: .inline)
        }
        
    }
}


