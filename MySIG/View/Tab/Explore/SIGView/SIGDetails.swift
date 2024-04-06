//
//  SIGDetails.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 06/04/24.
//

import SwiftUI

struct SIGDetails: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    var selectedSIG: SIG
    
    var body: some View {
        VStack(alignment: .center) {
            VStack (alignment: .leading) {
                Text("\(selectedSIG.name.capitalized)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 1)
                Text("\(selectedSIG.desc)")
                    .font(.subheadline)
                    .padding(.bottom, 20)
                
                if let user = Utils().getUserFromSIG(
                    sigData: selectedSIG,
                    appStoreData: appDataStore) {
                    
                    InformationRowView(
                        informationType: "PIC",
                        informationData: user.name
                    )
                }
                
                VStack(alignment: .leading, content: {
                    Text("Event List")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .center) {
                        let eventList = Utils().getAllEventFromListId(
                            eventIdList: selectedSIG.listEventId,
                            appStoreData: AppDataStore()
                        )
                        
                        if eventList.isEmpty {
                            Text("There's no event at the moment...")
                                .font(.footnote)
                                .foregroundStyle(Color.gray)
                            Spacer()
                        } else {
                            EventListView(eventList: eventList)
                        }
                        
                    }
                })
                .padding(.top, 30)
                
            }
            .padding(.horizontal, 24)
            
            
            Divider()
                .frame(height: 1)
            Button(action: {
                // Join SIG
            }, label: {
                Text("Subscribe notification")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            })
            .buttonStyle(.borderedProminent)
            .padding(.top, 10)
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 16)
        .navigationTitle("SIG Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        SIGDetails(selectedSIG: AppDataStore().sigs[3])
            .environmentObject(AppDataStore())
    }
}
