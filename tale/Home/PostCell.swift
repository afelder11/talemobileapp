//
//  PostCell.swift
//  tale
//
//  Created by Austin Felder on 9/14/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI


struct PostCell : View {
    var currentPost : Post
    
    @Environment(\.imageCache) var cache : ImageCache
    
    var body: some View {
        VStack {
            VStack {
                if URL(string: currentPost.imageURL) != nil {
                    AsyncImage(url : URL(string: currentPost.imageURL)!, placeholder : {Text ("loading ")},image:{Image(uiImage : $0).resizable()}).frame(height : (UIScreen.main.bounds.width - 20) * CGFloat(currentPost.aspectRatio))
                }
            
           
            HStack {
                if URL(string: currentPost.user?.profileImageURL ?? "") != nil {
                    AsyncImage(url : URL(string: currentPost.user?.profileImageURL ?? "")!, placeholder : {Text ("loading ")},image:{Image(uiImage : $0).resizable()}).frame(width: 50, height: 50, alignment: .center).cornerRadius(25)
                }
                VStack(alignment: .leading) {
                    Text(currentPost.user?.username ?? "")
                    Text(currentPost.date?.formatDate() ?? "").font(.caption).foregroundColor(.gray)
                }
                
                Spacer()
            }.padding()
            Divider().padding(.horizontal)
                Text(self.currentPost.comment).lineLimit(nil).padding().frame(maxWidth: .infinity, alignment: .leading)
            }.background(Color.white).cornerRadius(20).shadow(radius: 10).padding()
        }
    }
}

