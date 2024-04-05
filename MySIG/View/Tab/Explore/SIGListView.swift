//
//  SIGListView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 04/04/24.
//

import SwiftUI

struct SIGListView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    @Binding var searchedText: String
    
    var body: some View {
        Text("Hello, SIG List View!")
    }
}

#Preview {
    SIGListView(searchedText: .constant("Badminton"))
        .environmentObject(AppDataStore())
}
