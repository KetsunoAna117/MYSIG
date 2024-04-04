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
        NavigationStack{
            VStack {
                
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppDataStore())
}
