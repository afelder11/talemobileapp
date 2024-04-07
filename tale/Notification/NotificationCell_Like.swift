//
//  NotificationCell-Like.swift
//  tale
//
//  Created by Austin Felder on 9/18/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI

struct NotificationCell_Like : View {
    var body: some View {
        
        VStack {
            HStack(alignment: .top) {
                ZStack {
                    
                    Image("29").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/).frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).cornerRadius(5)
                    
                    NavigationLink(
                        destination: SinglePostView(currentPost: Post()),
                        label: {
                            EmptyView()
                        }).buttonStyle(PlainButtonStyle()).frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).cornerRadius(5).clipped()
                
                }
                
                VStack(alignment: .leading) {
                    Text("Joe liked your post!").font(.callout)
                    Text("One hour ago.").font(.caption)
                }
                Spacer()
            }.padding()
        }.background(Color.white).cornerRadius(5).shadow(radius: 10).padding()
    }
}

struct NotificationCell_Like_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell_Like()
    }
}
