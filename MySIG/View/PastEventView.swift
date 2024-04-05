//
//  PastEventView.swift
//  MySIG
//
//  Created by Tania Cresentia on 03/04/24.
//

import SwiftUI

struct PastEventView: View {
    @State private var searchText = ""
    let items = ["Basketball", "Badminton", "Board Game", "Tennis", "Volley"]
    var filteredItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                List(filteredItems, id: \.self) { item in
                    Text(item)
                }
                .listStyle(.plain)
                .searchable(text: $searchText, placement:.navigationBarDrawer(displayMode:.always), prompt: "Search items")
            }
            Spacer()
        }
        .navigationTitle("Past Events")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    PastEventView()
}
