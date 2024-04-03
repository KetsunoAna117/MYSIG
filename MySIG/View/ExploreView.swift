//
//  ExploreView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    
    var body: some View {
        Text("Hello, Explore!")
    }
}

#Preview {
    ExploreView()
        .environmentObject(AppDataStore())
}
