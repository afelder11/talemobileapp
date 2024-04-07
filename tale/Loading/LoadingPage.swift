//
//  LoadingPage.swift
//  tale
//
//  Created by Austin Felder on 4/19/21.
//  Copyright © 2021 afellaproductions. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingView : View {
    @EnvironmentObject var dataHandler : DataHandler
    @State var isLoggedIn : Bool = false
    @State var isLoaded : Bool = false
    var body : some View{
        Group {
            if isLoaded == false {
                Text("Tale").bold().font(.largeTitle)
            } else {
            if isLoggedIn == true {
                TabViewController(dataHandler: dataHandler, isLoggedIn: self.$isLoggedIn)
            } else {
                LoginView(isLoggedIn: self.$isLoggedIn)
            }
        }
        }.onAppear() {
            self.dataHandler.checkIfLoggedIn(completion: {
                isLoggedIn in
                if isLoggedIn == true {
                    self.isLoggedIn = true
                } else {
                    self.isLoggedIn = false
                }
                self.isLoaded = true
            })
        }
    }
}
