//
//  ParticipantListView.swift
//  MySIG
//
//  Created by Tania Cresentia on 06/04/24.
//

import SwiftUI

struct ParticipantListView: View {
    let participantList: [User]
    
    var body: some View {
        if participantList.isEmpty == false {
            List {
                ForEach(participantList, id: \.self) { anUser in
                        ParticipantCardView(userData: anUser)
                        .environmentObject(AppDataStore())
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    ParticipantListView(participantList: Utils().getUsersRegisteredForEvent(eventData: AppDataStore().events[0], appStoreData: AppDataStore()))
}
