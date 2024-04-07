//
//  ParticipantListView.swift
//  MySIG
//
//  Created by Tania Cresentia on 06/04/24.
//

import SwiftUI

struct ParticipantListView: View {
    @EnvironmentObject private var appStoreData: AppDataStore
    let participantList: [User]
    let sigId: Int
    
    var body: some View {
        if participantList.isEmpty == false {
            ForEach(participantList, id: \.self) { anUser in
                let isSIGPIC = Utils().validateIfUserIsSIGPIC(
                    userId: anUser.id,
                    sigId: sigId,
                    appStoreData: appStoreData)
                
                ParticipantCardView(
                    userData: anUser,
                    isSIGPIC: isSIGPIC
                )
                    .environmentObject(AppDataStore())
            }
        }
    }
}

#Preview {
    ParticipantListView(participantList: Utils().getUsersRegisteredForEvent(eventData: AppDataStore().events[0], appStoreData: AppDataStore()), sigId: 1)
        .environmentObject(AppDataStore())
}
