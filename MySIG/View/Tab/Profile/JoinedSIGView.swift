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
                List {
                    ForEach(filteredItems, id: \.self) { sig in
                        SIGCardView(sigData: sig)
                            .environmentObject(appStoreData)
                            .background(
                                NavigationLink(
                                    destination: SIGDetails(selectedSIG: sig)
                                        .environmentObject(appStoreData),
                                    label: {
                                        Text("View Details")
                                            .foregroundColor(.blue)
                                            .font(.subheadline)
                                    }
                                )
                            )
                    }
                }
                .listStyle(.plain)
                .listRowSpacing(10)
                Spacer()
            }
            .searchable(text: $searchText, placement:.navigationBarDrawer(displayMode:.always), prompt: "Search items")
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
