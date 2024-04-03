//
//  MySIGApp.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 02/04/24.
//

import SwiftUI

@main
struct MySIGApp: App {
    @State var appDataStore = AppDataStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDataStore)
        }
    }
}
