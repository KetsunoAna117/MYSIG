//
//  JoinedSIGView.swift
//  MySIG
//
//  Created by Tania Cresentia on 03/04/24.
//

import SwiftUI

struct JoinedSIGView: View {
    @EnvironmentObject private var appStoreData: AppDataStore
    @State private var searchText = ""
    
    var filteredItems: [SIG] {
        if let user = appStoreData.currentActiveUser {
            let sigs = Utils().getAllSIGByUserId(
                userId: user.id,
                appStoreData: appStoreData
            )
            
            if searchText.isEmpty {
                return sigs
            } else {
                return sigs.filter { sig in
                    sig.name.lowercased().contains(searchText.lowercased())
                }
            }
        }
        
        return []
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                List(filteredItems, id: \.self) { item in
                    SIGCardView(sigData: item)
                }
                .listStyle(.plain)
                .searchable(text: $searchText, placement:.navigationBarDrawer(displayMode:.always), prompt: "Search items")
                
                Spacer()
            }
        }
        .navigationTitle("Subscribed SIG")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        JoinedSIGView()
            .environmentObject(AppDataStore())
    }
}


//other struct
