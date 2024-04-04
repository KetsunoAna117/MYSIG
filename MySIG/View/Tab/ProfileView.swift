//
//  ProfileView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    
    var body: some View {
        Text("Hello, Profile!")
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppDataStore())
}
