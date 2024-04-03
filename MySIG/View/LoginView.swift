//
//  LoginView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    
    var body: some View {
        Text("Hello, Login View!")
    }
}

#Preview {
    LoginView()
        .environmentObject(AppDataStore())
}
