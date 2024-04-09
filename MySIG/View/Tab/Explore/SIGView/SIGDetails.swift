//
//  SIGDetails.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 06/04/24.
//

import SwiftUI

struct SIGDetails: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    let selectedSIG: SIG
    @State private var showModal = false
    
    @State private var descDetent = PresentationDetent.medium
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                VStack (alignment: .leading) {
                    Text("\(selectedSIG.name.capitalized)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 1)
                    
                    Text("\(selectedSIG.desc)")
                        .font(.subheadline)
                        .foregroundStyle(Color.secondary)
                        .padding(.bottom, 10)
                        .lineLimit(4)
                        .truncationMode(.tail)
                        .onTapGesture {
                            self.showModal = true
                        }
                        .sheet(isPresented: $showModal) {
                            NavigationStack {
                                ScrollView {
                                    Text("\(selectedSIG.desc)")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.secondary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .navigationTitle("Details")
                                .navigationBarTitleDisplayMode(.inline)
                                .padding(.horizontal, 16)
                            }
                            .presentationDetents(
                                [.medium, .large],
                                selection: $descDetent
                            )
                        }
                    
                    if let user = Utils().getUserFromSIG(
                        sigId: selectedSIG.id,
                        appStoreData: appDataStore) {
                        
                        List {
                            InformationRowView(
                                informationIcon: "person.fill",
                                informationType: "PIC",
                                informationData: user.name
                            )
                        }
                        .listStyle(.plain)
                        .frame(height: 45)
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
                .padding(.horizontal, 20)
            }
            
            
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
        SIGDetails(selectedSIG: AppDataStore().sigs[0])
            .environmentObject(AppDataStore())
    }
}
