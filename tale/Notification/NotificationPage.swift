//
//  NotificationPage.swift
//  tale
//
//  Created by Austin Felder on 9/14/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI

struct NotificationView : View {
    @ObservedObject var dataHandler : DataHandler
    init(dataHandler : DataHandler) {
        UITableView.appearance().separatorColor = .clear
        self.dataHandler = dataHandler
    }
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(0 ..< 20, content:  {
                    i in
                    
                    NotificationCell_Like().listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                })
            }.navigationBarTitle("Notifications", displayMode: .inline
            )
        }
    }
}


