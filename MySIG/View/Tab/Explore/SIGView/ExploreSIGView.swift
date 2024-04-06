//
//  SIGListView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 04/04/24.
//

import SwiftUI

struct ExploreSIGView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    @Binding var searchedText: String
    
    @State var sigList: [SIG]
    
    var filteredSIGList: [SIG] {
        if(searchedText.isEmpty == false){
            return sigList.filter { sig in
                sig.name.lowercased().contains(searchedText.lowercased())
            }
        }
        return sigList
    }
    
    var body: some View {
        List {
            ForEach(filteredSIGList, id: \.self) { sig in
                SIGCardView(sigData: sig)
//                    .listRowInsets(EdgeInsets())
                    .environmentObject(appDataStore)
                    .background(
                        NavigationLink(
                            destination: SIGDetails(selectedSIG: sig),
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
    }
}

#Preview {
    NavigationStack {
        ExploreSIGView(searchedText: .constant(""), sigList: Utils().getAllSIG(appStoreData: AppDataStore()))
            .environmentObject(AppDataStore())
    }
}
