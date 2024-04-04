//
//  JoinedSIGView.swift
//  MySIG
//
//  Created by Tania Cresentia on 03/04/24.
//

import SwiftUI

struct JoinedSIGView: View {
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
            ZStack {
                Text("Subsribed SIG")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                HStack{
                    NavigationLink(destination: ProfileView().navigationBarBackButtonHidden()){
                        Image(systemName: "chevron.left")
                        
                        Text("Back")
                    }
                    
                    Spacer()
                }
                .padding(.leading, 10)
                .foregroundColor(.orange)
            }
            Divider()
                
            
            List(filteredItems, id: \.self) { item in
                Text(item)
            }
            .listStyle(.plain)
            .searchable(text: $searchText, placement:.navigationBarDrawer(displayMode:.always), prompt: "Search items")
            
        }
    }
}

#Preview {
    JoinedSIGView()
}


//other struct
