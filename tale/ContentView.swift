//
//  ContentView.swift
//  tale
//
//  Created by Austin Felder on 9/14/20.
//  Copyright © 2020 afellaproductions. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataHandler : DataHandler
    @State var isLoggedIn : Bool = false

    var body: some View {
        TabViewController(dataHandler:dataHandler, isLoggedIn: self.$isLoggedIn)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


