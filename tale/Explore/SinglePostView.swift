//
//  SignlePostView.swift
//  tale
//
//  Created by Austin Felder on 9/18/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI

struct SinglePostView : View {
    
    var currentPost : Post
    var body : some View {
        List {
            PostCell(currentPost: self.currentPost).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}


