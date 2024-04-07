//
//  ExplorePage.swift
//  tale
//
//  Created by Austin Felder on 9/14/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI


struct ExploreView : View {
    @ObservedObject var dataHandler : DataHandler
    @State var isSearching : Bool = false
    @State var searchText = String()
    @Environment(\.imageCache) var cache : ImageCache
    var body:some View {
        NavigationView {
            VStack {
                TextField("Search...", text: self.$searchText, onEditingChanged: {
                    changed in
                }, onCommit: {
                    self.search()
                }).padding()
                
                if isSearching == true {
                    List {
                        ForEach(self.dataHandler.searchPosts, id: \.id, content: {
                            post in
                            PostCell(currentPost: post).listRowInsets(EdgeInsets(top: 0, leading: 1, bottom: 0, trailing: 0))
                        })
                    }
                    .padding(-1.0)
                }
                else {
                    
                    
                    
                    QGrid(self.dataHandler.explorePagePosts, columns: 3, columnsInLandscape: nil, vSpacing: 0, hSpacing: 0, vPadding: 0, hPadding: 0, isScrollable: true, showScrollIndicators: false, content: {
                    post in
                    
                    NavigationLink(
                        destination: SinglePostView(currentPost: post.post),
                        label: {
                            AsyncImage(url : URL(string: post.post.imageURL)!, placeholder : {Text ("loading ")},image:{Image(uiImage : $0).resizable()}).aspectRatio(contentMode: .fill).frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3, alignment: .center).clipped()
                            
                        }).buttonStyle(PlainButtonStyle())
                    
                })
                }
            } .navigationBarTitle("Explore", displayMode: .inline)
        }
    }
    
    func search() {
        if self.searchText == "" {
            self.isSearching = false
        }
        else {
            self.isSearching = true
            self.dataHandler.loadPostsFrom(self.searchText.lowercased())
        }
    }
}

struct PostIdentifiable : Identifiable {
    var id = UUID()
    var post : Post

}

