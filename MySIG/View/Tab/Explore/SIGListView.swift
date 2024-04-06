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
    
    @State var sigList: [SIG]
    
    var filteredSIGList: [SIG] {
        if(searchedText.isEmpty == false){
            return sigList.filter { sig in
                Utils().getSigById(sigId: sig.id, appStoreData: appDataStore)?
                    .name.contains(searchedText) ?? false
            }
        }
        return sigList
    }
    
    var body: some View {
        List {
            ForEach(filteredSIGList, id: \.self) { sig in
                SIGCardView(sigData: sig)
                    .listRowInsets(EdgeInsets())
                    .environmentObject(appDataStore)
            }
        }
        .listStyle(.plain)
        .listRowSpacing(10)
    }
}

#Preview {
    SIGListView(searchedText: .constant(""), sigList: Utils().getAllSIG(appStoreData: AppDataStore()))
        .environmentObject(AppDataStore())
}
